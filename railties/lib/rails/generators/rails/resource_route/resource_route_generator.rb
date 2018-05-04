# frozen_string_literal: true

module Rails
  module Generators
    class ResourceRouteGenerator < NamedBase # :nodoc:
      # Properly nests namespaces passed into a generator
      #
      #   $ rails generate resource admin/users/products
      #
      # should give you
      #
      #   namespace :admin do
      #     namespace :users do
      #       resources :products
      #     end
      #   end
      def add_resource_route
        return if options[:actions].present?

        depth = 0
        lines = []

        # Create 'namespace' ladder
        # namespace :foo do
        #   namespace :bar do
        regular_class_path.each do |ns|
          lines << optimize_indentation("namespace :#{ns} do", depth * 2)
          depth += 1
        end

        # inserts the primary resource
        # Create route
        #     resources 'products'
        lines << optimize_indentation(%{resources :#{file_name.pluralize}}, depth * 2)

        # Create `end` ladder
        #   end
        # end
        until depth.zero?
          depth -= 1
          lines << optimize_indentation("end", depth * 2)
        end

        route lines.join
      end
    end
  end
end
