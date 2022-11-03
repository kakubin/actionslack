# ActionSlack

ActionSlack is a framework that supports your implementation of slack notification functionality, inspierd by Rails.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add actionslack

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install actionslack

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

## Development

I will not release this to rubygems until becomes stable.
Until then, I develop this privately.

I'm also planning providing rspec tools. Stay tuned.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakubin/actionslack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kakubin/actionslack/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the ActionSlack project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kakubin/actionslack/blob/main/CODE_OF_CONDUCT.md).
