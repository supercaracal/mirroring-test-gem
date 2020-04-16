# frozen_string_literal: true

# Call a same method for multiple receivers
class MirroringTest
  def initialize(*receivers)
    @receivers = receivers
  end

  def class
    @receivers.first.class
  end

  def is_a?(mod)
    @receivers.first.is_a?(mod)
  end

  alias kind_of? is_a?
  alias instance_of? is_a?

  private

  def method_missing(method_name, *args, &block) # rubocop:disable Style/MethodMissingSuper
    @receivers.map do |r|
      r.send(method_name, *args, &block) if r.respond_to?(method_name)
    end.first
  end

  def respond_to_missing?(symbol, include_private)
    @receivers.first.respond_to?(symbol) ? true : super
  end
end
