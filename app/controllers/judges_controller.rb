class JudgesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @videos = Judge.find(id).get_videos()
  end
end
