class OrgChartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @histogram = People::Person.histogram
  end
end
