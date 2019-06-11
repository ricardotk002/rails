# frozen_string_literal: true

require "active_support/core_ext/module/attribute_accessors_per_thread"

module ActiveRecord
  # This is a thread locals registry for Active Record. For example:
  #
  #   ActiveRecord::RuntimeRegistry.connection_handler
  #
  # returns the connection handler local to the current thread.
  #
  # See the documentation of Module::thread_mattr_accessor
  # for further details.
  class RuntimeRegistry # :nodoc:
    thread_mattr_accessor :connection_handler
    thread_mattr_accessor :sql_runtime
  end
end
