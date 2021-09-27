module Api
  class OrgChartsController < ApplicationController
    # before_action :authenticate_user!

    def show
      current_date = Date.parse(params.fetch(:effective_date, Date.current.iso8601))

      render :json => {
        :current_date => current_date,
        :people => People::Person.find_for(current_date) || [],
        :histogram => [
          {date: "2021-09-01", value: 100},
          {date: "2021-10-01", value: 100},
          {date: "2021-11-01", value: 100},
          {date: "2021-12-01", value: 100},
        ],
        :connections => Connections::Connection.find_for(current_date) || []
      }
    end
  end
end
