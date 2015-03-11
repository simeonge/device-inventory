class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: "admin", password: "secret"

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
    @status = Status.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    @status = Status.new(code: params[:device][:code])

    respond_to do |format|
      Device.transaction do
        begin
          if @device.save && @status.save
            format.html { redirect_to @device, notice: 'Device was successfully created.' }
            format.json { render :show, status: :created, location: @device }
          else 
            format.html { render :new }
            format.json { render json: @device.errors, status: :unprocessable_entity }
          end
        rescue
        end
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      Device.transaction do
        if @device.update(device_params) && @status.update(code: params[:device][:code])
          format.html { redirect_to @device, notice: 'Device was successfully updated.' }
          format.json { render :show, status: :ok, location: @device }
        else
          format.html { render :edit }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    Device.transaction do
      @device.destroy
      @status.destroy
    end
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
      @status = Status.find_by(code: @device.code)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:os, :model, :code)
    end
end
