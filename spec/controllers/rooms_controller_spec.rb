require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
    describe "GET /rooms" do
        it "returns a 201 status code" do
            get :rooms
            expect(response).to have_http_status(201)
        end
    end
end
