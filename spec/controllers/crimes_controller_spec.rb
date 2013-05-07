require "spec_helper"

describe CrimesController do
	describe "GET #search" do
		it "responds successfully with an HTTP 200 status code" do
			get :search
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the search template" do
			get :search
			expect(response).to render_template("search")
		end
	end


end