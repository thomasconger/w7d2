class BandsController < ApplicationController

  before_action :set_band, only:[:show, :edit, :update, :destroy]

  def set_band
    @band = Band.find_by(id: params[:id])
  end

  def index
    render :index
  end

  def create
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

end
