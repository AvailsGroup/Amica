require 'rails_helper'

RSpec.describe "Whispers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/whispers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/whispers/show"
      expect(response).to have_http_status(:success)
    end
  end

end
