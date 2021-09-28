class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_date = Date.parse(params.fetch(:effective_date, Date.current.iso8601))
    @flat_org_chart = TeamChart.find_for(@current_date) || []
    @histogram = People::Person.histogram
  end
end
