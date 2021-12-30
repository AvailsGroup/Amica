class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def create
    @tag = Tag.new(tag_params)
    @tag.community_id = params[:community_id]
    redirect_to(edit_community_path(params[:community_id]),method: :get)
  end

  def destroy
    Tag.find_by(community_id:params[:community_id],tag:params[:id]).destroy
    redirect_to(edit_community_path(params[:community_id]),method: :get)
  end

  private

  def tag_params
    params.require(:tag).permit(:tag)
  end

end
