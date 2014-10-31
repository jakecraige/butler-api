module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end
        end

        rescue_from NoMethodError do |e|
          error_response(message: e.message, status: 500)
        end
      end
    end
  end
end
