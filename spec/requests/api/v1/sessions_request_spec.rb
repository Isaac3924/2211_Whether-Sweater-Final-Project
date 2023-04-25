require 'rails_helper'
RSpec.describe "Sessions", type: :request do
  describe "POST /api/v1/sessions" do
    let(:user_valid_attributes) do
      {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
      }
    end

    let(:session_valid_attributes) do
      {
          email: "whatever@example.com",
          password: "password"
      }
    end

    let(:session_password_invalid_attributes) do
      {
          email: "whatever@example.com",
          password: "blargh"
      }
    end

    let(:session_invalid_email_attributes) do
      {
          email: "wrong@example.com",
          password: "password"
      }
    end

    context "when the request is valid" do
      before { post "/api/v1/users", params: user_valid_attributes, as: :json }

      it "creates a new user" do
        post "/api/v1/sessions", params: session_valid_attributes, as: :json
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
				expect(pretty["data"]["attributes"]["email"]).to eq("whatever@example.com")
        expect(pretty["data"]["attributes"]["api_key"]).to be_a(String)
        expect(pretty["data"]["attributes"].keys).to_not include("password")
        expect(pretty["data"]["attributes"].keys).to_not include("password_confirmation")
        expect(pretty["data"]["attributes"].keys.length).to eq(2)
        expect(pretty["data"].keys.length).to eq(3)
        expect(pretty["data"].keys).to eq(["type", "id", "attributes"])

        expect(User.all.length).to eq(1)
        expect(User.last.email).to eq("whatever@example.com")
        expect(pretty["data"]["id"]).to eq(User.last.id.to_s)
        expect(pretty["data"]["attributes"]["email"]).to eq(User.last.email)
        expect(pretty["data"]["attributes"]["api_key"]).to eq(User.last.api_key)
      end
    end

    context "when the request is invalid" do
      before { post "/api/v1/users", params: user_valid_attributes, as: :json }

      it "returns an error for incorrect email" do
        post "/api/v1/sessions", params: session_password_invalid_attributes, as: :json
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
				expect(pretty["error"]).to eq("Incorrect Login.")
      end

      it "returns same error for incorrect password" do
        post "/api/v1/sessions", params: session_invalid_email_attributes, as: :json
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
				expect(pretty["error"]).to eq("Incorrect Login.")
      end
    end
  end
end