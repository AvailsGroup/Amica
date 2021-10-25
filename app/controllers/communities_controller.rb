class CommunitiesController < ApplicationController
  def index

  end
  def new
    @community = Community.new
  end
end
