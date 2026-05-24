# frozen_string_literal: true

class FluckWebsiteAttackStore
  def initialize
    @data = {}
    @mutex = Mutex.new
  end

  def read(key)
    @mutex.synchronize { entry(key) }
  end

  def write(key, value, options = {})
    expires = options[:expires_in] ? (Time.now.to_f + options[:expires_in]) : nil
    @mutex.synchronize { @data[key] = [value, expires] }
    value
  end

  def increment(key, amount = 1, options = {})
    @mutex.synchronize do
      current = entry(key) || 0
      new_value = current.to_i + amount
      expires = options[:expires_in] ? (Time.now.to_f + options[:expires_in]) : nil
      @data[key] = [new_value, expires]
      new_value
    end
  end

  def delete(key)
    @mutex.synchronize { @data.delete(key) }
  end

  private

  def entry(key)
    value, expires = @data[key]
    return nil if value.nil?

    if expires && Time.now.to_f > expires
      @data.delete(key)
      nil
    else
      value
    end
  end
end

Rack::Attack.cache.store = FluckWebsiteAttackStore.new

Rack::Attack.throttled_responder = lambda do |_request|
  [429, {"content-type" => "text/plain"}, ["Too many requests. Try again in a minute.\n"]]
end
