#require 'net/http' #to avoid cors error
require 'json' # Required to parse JSON

class FetchDataController < ApplicationController
  def index

    random_number = rand(0..100)
    data = [random_number]

    render json: data
  end
end
