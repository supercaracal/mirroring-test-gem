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

  def method_missing(method_name, *args, &block)
    first_ret_pair = @receivers.map do |r|
      ret = [nil, nil]

      next(ret) unless r.respond_to?(method_name)

      begin
        ret[0] = r.send(method_name, *args, &block)
      rescue StandardError => e
        ret[1] = e
      end

      ret
    end.first

    raise(first_ret_pair[1]) unless first_ret_pair[1].nil?

    first_ret_pair[0]
  end

  def respond_to_missing?(symbol, include_private)
    @receivers.first.respond_to?(symbol) ? true : super
  end
end
