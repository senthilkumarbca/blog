require 'rails_helper'

RSpec.describe "UserCommentRatings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/user_comment_ratings/index"
      expect(response).to have_http_status(:success)
    end
  end

end
