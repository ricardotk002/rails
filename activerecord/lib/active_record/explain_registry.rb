# frozen_string_literal: true

require "active_support/core_ext/module/attribute_accessors_per_thread"

module ActiveRecord
  # This is a thread locals registry for EXPLAIN. For example
  #
  #   ActiveRecord::ExplainRegistry.queries
  #
  # returns the collected queries local to the current thread.
  #
  # See the documentation of Module::thread_mattr_accessor
  # for further details.
  class ExplainRegistry # :nodoc:
    thread_mattr_accessor :queries, default: []
    thread_mattr_accessor :collect, default: false

    class << self
      def collect?
        collect
      end

      def reset
        self.queries = []
        self.collect = false
      end
    end
  end
end
