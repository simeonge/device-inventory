class HistoryController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "secret"
  def index
    @records = History.all
  end
end
