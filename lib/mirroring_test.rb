# frozen_string_literal: true

# Call a same method for multiple receivers
class MirroringTest
  def initialize(*receivers)
    @receivers = receivers
  end

  def method_missing(method_name, *args, &block) # rubocop:disable Style/MethodMissingSuper
    @receivers.map do |r|
      r.send(method_name, *args, &block) if r.respond_to?(method_name)
    end.first
  end

  def respond_to_missing?(symbol, include_private)
    @receivers.first.respond_to?(symbol) ? true : super
  end
end
