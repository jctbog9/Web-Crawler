class Api::V1::DataController < ApplicationController
  def index
    render json: Crawler.new.create_data
  end
end
