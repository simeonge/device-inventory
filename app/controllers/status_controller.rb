class StatusController < ApplicationController
  before_action :set_status, only: [:checkin, :checkout, :take, :return]

  def index
    @statuses = Status.joins('LEFT OUTER JOIN devices ON devices.code = statuses.code').select("statuses.*, devices.*")
  end

  # GET /status/checkout
  def checkout
  end

  # GET /status/checkin
  def checkin
  end

  # PUT /status/1
  def take
    respond_to do |format|
      if @statu.update(status_params)
        format.html { redirect_to @statu, notice: 'Device has been checked out.' }
        format.json { render :show, status: :ok, location: @statu }
      else
        format.html { render :edit }
        format.json { render json: @statu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status/1
  # update history model
  def return
    record = History.new(params[:status][:code], params[:status][:holder], @statu.time, params[:status][:time])

    respond_to do |format|
      Status.transaction do
        if @statu.update(status_params) && record.save
          format.html { redirect_to @statu, notice: 'Device has been returned.' }
          format.json { render :show, status: :ok, location: @statu }
        else
          format.html { render :edit }
          format.json { render json: @statu.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    def set_status
      @statu = Status.find_by(code: params[:code])
    end

    def status_params
      params.require(:status).permit(:code, :holder, :time)
    end
end