# ActionSlack

ActionSlack is a framework that supports your implementation of slack notification functionality, inspierd by Rails.

## Installation

```ruby
gem 'actionslack', require: 'action_slack'
```

That's all

## Usage

First, prepare a file with name 'config/slack_webhooks.yml' and register name and url fields of [Slack Incoming Webhook](https://slack.com/help/articles/115005265063-Incoming-webhooks-for-Slack) as array.

```yaml
- name: channel_onboarding
  url: https://hooks.slack.com/services/DUMMY/INCOMING_WEBHOOK_URL
```

Next, define two methods.
One is the template for the message to be sent.
The other must be a name of one of addresses you have just registered in `config/slack_webhooks.yml`.

Once everything is registered, you just call method `notify` to that template.

```ruby
class WelcomingNewCommer < ActionSlack::Base
  self.attributes = [:new_person]

  def webhook_name
    'channel_onboarding'
  end

  def message
    <<~MSG
      Welcome, #{new_person.name}
    MSG
  end
end

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

person = Person.new('John')

WelcomingNewCommer.notify(new_person: person)
```

Optionally, three configuration items are available.

Especially, there are three options for type: local, testflight, and production.

In `local`, ActionSlack does not post to Slack, only writes logs.
In `testflight`, ActionSlack will post to Slack, but adds an obvious prefix to the message to tell you that it is not a notice from a production environment.
So, I recommend to use it for checking connections.

I know you understand about `production` mode.

```ruby
ActionSlack.configure do |config|
  config.filepath = "#{PROJECT_ROOT}/webhooks.yml"
  config.async = false # then, we don't use ActiveJob for posting
  config.type = :production
end
```

## Development

I'm planning provide rspec tools.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakubin/actionslack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kakubin/actionslack/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the ActionSlack project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kakubin/actionslack/blob/main/CODE_OF_CONDUCT.md).
