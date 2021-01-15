class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  def index
    @attractions = Attraction.all
  end

 
  def show
  end


  def new
    redirect_if_not_admin
    @attraction = Attraction.new
  end

  def edit
    redirect_if_not_admin
  end

  def create
    @attraction = Attraction.new(attraction_params)

    respond_to do |format|
      if @attraction.save
        format.html { redirect_to @attraction, notice: 'Attraction was successfully created.' }
        format.json { render :show, status: :created, location: @attraction }
      else
        format.html { render :new }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attraction.update(attraction_params)
        format.html { redirect_to @attraction, notice: 'Attraction was successfully updated.' }
        format.json { render :show, status: :ok, location: @attraction }
      else
        format.html { render :edit }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to attractions_url, notice: 'Attraction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def takeride
    set_attraction 
    user = current_user
    msg = Ride.create(user: user, attraction: @attraction).take_ride
    redirect_to(user_path(user), notice: msg)
  end

  private
    def set_attraction
      @attraction = Attraction.find(params[:id])
    end

    def attraction_params
      params.require(:attraction).permit(
        :name,
        :tickets,
        :happiness_rating,
        :nausea_rating,
        :min_height
      )
    end
end
