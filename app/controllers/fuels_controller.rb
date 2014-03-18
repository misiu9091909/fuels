class FuelsController < ApplicationController
  before_action :set_fuel, only: [:show, :edit, :update, :destroy]

  # GET /fuels
  # GET /fuels.json
  def index
    @fuels = Fuel.all
    @fuels_current = Fuel.where(:created_at => Fuel.maximum(:created_at))
  end

  # GET /fuels/1
  # GET /fuels/1.json
  def show
  end

  # GET /fuels/new
  def new
    @fuel = Fuel.new
  end

  # GET /fuels/1/edit
  def edit
  end

  # POST /fuels
  # POST /fuels.json
  def create
    @fuel = Fuel.new(fuel_params)

    respond_to do |format|
      if @fuel.save
        format.html { redirect_to @fuel, notice: 'Fuel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fuel }
      else
        format.html { render action: 'new' }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuels/1
  # PATCH/PUT /fuels/1.json
  def update
    respond_to do |format|
      if @fuel.update(fuel_params)
        format.html { redirect_to @fuel, notice: 'Fuel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def check_remote
    Fuel.load_data_from_remote
	redirect_to :back, notice: "refreshed"
	flash[:notice] = "refreshed"
  end

  # DELETE /fuels/1
  # DELETE /fuels/1.json
  def destroy
    @fuel.destroy
    respond_to do |format|
      format.html { redirect_to fuels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel
      @fuel = Fuel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fuel_params
      params[:fuel]
    end
end
