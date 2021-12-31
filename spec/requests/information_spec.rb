require 'rails_helper'

RSpec.describe "Information", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/informations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/informations/show"
      expect(response).to have_http_status(:success)
    end
  end

end
