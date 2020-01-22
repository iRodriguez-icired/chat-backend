class RoomsController < ApplicationController
  
  def show
    Room.all
  end
end
