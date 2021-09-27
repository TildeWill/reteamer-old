module Api
  class OrgChartsController < ApplicationController
    before_action :authenticate_user!

    def show
      current_date = Date.parse(params.fetch(:effective_date, Date.current.iso8601))

      render :json => {
        :current_date => current_date,
        :people => People::Person.find_for(current_date) || [],
        :histogram => People::Person.histogram,
        :connections => Connections::Connection.find_for(current_date) || []
      }
    end
  end
end
