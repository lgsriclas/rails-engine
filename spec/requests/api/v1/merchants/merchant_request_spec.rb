require 'rails_helper'

describe "Merchant API endpoints" do
  it "can get one merchant by its id" do
    create_list(:merchant, 10)
    get "/api/v1/merchants/#{Merchant.first.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'sends error code if merchant does not exist' do
    create_list(:merchant, 10)

    get "/api/v1/merchants/100"

    expect(response.status).to eq(404)
  end
end