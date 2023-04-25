require 'rails_helper'
RSpec.describe "Users", type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) do
      {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password",
      }
    end

    let(:password_mismatch_attributes) do
      {
          email: "whoever@example.com",
          password: "password",
          password_confirmation: "blargh",
      }
    end

    let(:invalid_attributes) do
      {
          email: "wrong@example.com",
          password: "",
          password_confirmation: "",
      }
    end

    context "when the request is valid" do
      before { post "/api/v1/users", params: valid_attributes }

      it "creates a new user" do
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
				expect(pretty["data"]["attributes"]["email"]).to eq("whatever@example.com")
        expect(pretty["data"]["attributes"]["api_key"]).to be_a(String)
        expect(pretty["data"]["attributes"].keys).to_not include("password")
        expect(pretty["data"]["attributes"].keys).to_not include("password_confirmation")
        expect(pretty["data"]["attributes"].keys.length).to eq(2)
        expect(pretty["data"].keys.length).to eq(3)
        expect(pretty["data"].keys).to eq(["type", "id", "attributes"])

        expect(User.last.email).to eq("whatever@example.com")
      end
    end

    context "when the request is invalid" do
      before { post "/api/v1/users", params: valid_attributes }

      it "returns an error for bad mismatched passwords" do
        post "/api/v1/users", params: password_mismatch_attributes
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
				expect(pretty["error"]).to eq("Password and password confirmation do not match")

        expect(User.last.email).to_not eq("whoever@example.com")
      end

      it "returns an error for existing user" do
        post "/api/v1/users", params: valid_attributes
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
				expect(pretty["error"]).to eq("Email already exists")

        expect(User.all).to eq([User.last])
      end

      it "returns an error for missing field(s)" do
        post "/api/v1/users", params: invalid_attributes
        pretty = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
				expect(pretty["error"]).to eq("Email, password, and password confirmation are required fields")

        expect(User.last.email).to_not eq("wrong@example.com")
      end

    end
  end
end