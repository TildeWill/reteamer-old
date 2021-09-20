class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  # GET /person_snapshots or /person_snapshots.json
  def index
    @current_date = Date.parse(params.fetch(:effective_date, Date.current.iso8601))
    @flat_org_chart = People.find_for(@current_date) || []
    @histogram = People.histogram
  end

  # # GET /person_snapshots/1 or /person_snapshots/1.json
  # def show
  # end
  #
  # # GET /person_snapshots/new
  # def new
  #   @person_snapshot = PersonSnapshot.new
  # end
  #
  # # GET /person_snapshots/1/edit
  # def edit
  # end
  #
  # # POST /person_snapshots or /person_snapshots.json
  # def create
  #   @person_snapshot = PersonSnapshot.new(person_snapshot_params)
  #
  #   respond_to do |format|
  #     if @person_snapshot.save
  #       format.html { redirect_to @person_snapshot, notice: "Person snapshot was successfully created." }
  #       format.json { render :show, status: :created, location: @person_snapshot }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @person_snapshot.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /person_snapshots/1 or /person_snapshots/1.json
  # def update
  #   respond_to do |format|
  #     if @person_snapshot.update(person_snapshot_params)
  #       format.html { redirect_to @person_snapshot, notice: "Person snapshot was successfully updated." }
  #       format.json { render :show, status: :ok, location: @person_snapshot }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @person_snapshot.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /person_snapshots/1 or /person_snapshots/1.json
  # def destroy
  #   @person_snapshot.destroy
  #   respond_to do |format|
  #     format.html { redirect_to person_snapshots_url, notice: "Person snapshot was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_person
  #     @person_snapshot = PersonSnapshot.find(params[:id])
  #   end
  #
  #   # Only allow a list of trusted parameters through.
  #   def person_snapshot_params
  #     params.require(:person_snapshot).permit(:meta_id, :effective_at, :first_name, :last_name, :title, :manager_id)
  #   end
end
