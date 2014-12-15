module API
  module V1
    class Reports < Grape::API
      include API::V1::Defaults

      resource :freshbooks do
        resource :time_entries do
          desc 'Return all time entries for given projects.'
          params do
            requires :project_ids, type: Array,
              desc: 'Freshbooks IDs of Projects to get back'

            optional :start_date, type: Date, default: Time.now - 2.years,
              desc: 'Start date of query', default: Time.now - 2.years

            optional :end_date, type: Date, default: Time.now,
              desc: 'End date of query'

            optional :billable, type: Boolean, default: true,
              desc: 'End date of query'
          end

          get do
            client = FreshBooksApi::TimeEntries.new(ENV['FB_API_URL'], ENV['FB_AUTH_TOKEN'])

            entries = client.report(project_ids: permitted_params[:project_ids],
                                    from: permitted_params[:start_date],
                                    to: permitted_params[:end_date])

            { time_entries: entries }
          end
        end
      end
    end
  end
end