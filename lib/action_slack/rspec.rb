# frozen_string_literal: true

module ActionSlack
  class Rspec
    ::RSpec.configure do |c|
      c.include(ExpectedMessage, type: :slack)
    end

    module ExpectedMessage
      config.before(type: :slack) do
        described_class.class_eval do
          def method_missing(method_name, *args)
            if RSpec.current_example.instance_variable_get(:@example_group_instance).respond_to?(method_name)
              RSpec.current_example.instance_variable_get(:@example_group_instance).__send__(method_name)
            else
              super
            end
          end

          def respond_to_missing?(method_name, *args)
            RSpec.current_example.instance_variable_get(:@example_group_instance).respond_to?(method_name) || super
          end
        end
      end

      shared_examples_for 'return expected message' do
        subject { instance.message }

        let(:instance) { described_class.new }

        it { is_expected.to eq expected }
      end
    end
  end
end
