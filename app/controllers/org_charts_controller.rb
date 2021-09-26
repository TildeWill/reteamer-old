class OrgChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_date = Date.parse(params.fetch(:effective_date, Date.current.iso8601))
    @flat_org_chart = People::Person.find_for(@current_date) || []
    @histogram = People::Person.histogram
    @connections = Connections::Connection.find_for(@current_date) || []
  end
end
