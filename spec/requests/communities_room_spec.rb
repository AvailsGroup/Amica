require 'rails_helper'

RSpec.describe "CommunitiesRooms", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/communities_room/show"
      expect(response).to have_http_status(:success)
    end
  end

end
