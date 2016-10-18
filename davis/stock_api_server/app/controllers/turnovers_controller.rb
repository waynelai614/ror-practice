class TurnoversController < ApplicationController
  before_action :set_turnover, only: [:show, :edit, :update, :destroy]

  # GET /turnovers
  # GET /turnovers.json
  # def index
  #   # @turnovers = Turnover.all
  # end
  def index
    oneDayTurnovers = TurnoverPerDay.new
    oneDayTurnovers.day = DateTime.now.beginning_of_day
    oneDayTurnovers.turnovers = []

    [[1,2,3,4,5,6,7,8,9,10], [1,2,3,4,5,6,7,8,9,10], [1,2,3,4,5,6,7,8,9,10]].each{ |obj|
        oneTurnover = Turnover.new(range: obj[0], number: obj[1], name: obj[2], startPrice: obj[3], highestPrice: obj[4], lowestPrice: obj[5], yesClose: obj[6], todayClose: obj[7], dealPrice: obj[8], dealDelta: obj[9])
        oneTurnover.day = DateTime.now.beginning_of_day
        oneTurnover.save!
        oneDayTurnovers.addTrunover(oneTurnover)
    }
    oneDayTurnovers.save!

    render json: Crawl.crawl
    # render json: { :hello=> "hello" }
  end

  # GET /turnovers/1
  # GET /turnovers/1.json
  def show
  end

  # GET /turnovers/new
  def new
    @turnover = Turnover.new
  end

  # GET /turnovers/1/edit
  def edit
  end

  # POST /turnovers
  # POST /turnovers.json
  def create
    @turnover = Turnover.new(turnover_params)

    respond_to do |format|
      if @turnover.save
        format.html { redirect_to @turnover, notice: 'Turnover was successfully created.' }
        format.json { render :show, status: :created, location: @turnover }
      else
        format.html { render :new }
        format.json { render json: @turnover.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turnovers/1
  # PATCH/PUT /turnovers/1.json
  def update
    respond_to do |format|
      if @turnover.update(turnover_params)
        format.html { redirect_to @turnover, notice: 'Turnover was successfully updated.' }
        format.json { render :show, status: :ok, location: @turnover }
      else
        format.html { render :edit }
        format.json { render json: @turnover.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turnovers/1
  # DELETE /turnovers/1.json
  def destroy
    @turnover.destroy
    respond_to do |format|
      format.html { redirect_to turnovers_url, notice: 'Turnover was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turnover
      @turnover = Turnover.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def turnover_params
      params.fetch(:turnover, {})
    end
end
