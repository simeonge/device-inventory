class StatusController < ApplicationController
  before_action :set_status, only: [:checkin, :checkout, :take, :return]
  http_basic_authenticate_with name: "admin", password: "secret", except: :display

  def display
    @statuses = Status.joins('LEFT OUTER JOIN devices ON devices.code = statuses.code').select("statuses.available, devices.*")
  end

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
      if @statu.update(holder: params[:status][:holder], time: params[:status][:time], available: false)
        format.html { redirect_to '/status/index', notice: 'Device has been checked out.' }
        format.json { render :index, status: :ok, location: @statu }
      else
        format.html { render :checkout }
        format.json { render json: @statu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status/1
  # update history model
  def return
    record = History.new(code: params[:status][:code], holder: params[:status][:holder], timeout: @statu.time, timein: params[:status][:time])

    respond_to do |format|
      Status.transaction do
        if @statu.update(holder: "", time: "", available: true) && record.save
          format.html { redirect_to '/status/index', notice: 'Device has been returned.' }
          format.json { render :show, status: :ok, location: @statu }
        else
          format.html { render :checkout }
          format.json { render json: @statu.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    def set_status
      @statu = Status.find_by(code: params[:code]) || Status.find_by(code: params[:status][:code])
    end

    def status_params
      params.require(:status).permit(:code, :holder, :time)
    end
end
