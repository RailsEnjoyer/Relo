# frozen_string_literal: true

class BaseService
  attr_accessor :result
  attr_writer :errors

  def call
    raise NotImplementedError, 'Method "call" must be implemented'
  end

  def self.call(*, **kwargs, &)
    if kwargs.empty?
      new(*).call
    else
      new(*, **kwargs).call
    end
  end

  def errors
    @errors ||= {}
  end

  def success?
    errors.empty?
  end

  def failure?
    !success?
  end
end
