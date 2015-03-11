class HistoryController < ApplicationController
  def index
    @records = History.all
  end
end
