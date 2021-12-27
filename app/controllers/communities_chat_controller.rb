class CommunitiesChatController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
end
