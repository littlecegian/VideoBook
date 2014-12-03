class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def index
  end
end
