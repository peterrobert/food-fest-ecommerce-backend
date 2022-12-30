require 'rails_helper'

RSpec.describe "Products", type: :request do

  let!(:products) { create_list(:product, 10) }
  let!(:product_id) { products.first.id }

  describe 'GET /products' do
    before { get '/api/v1/products' }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET /products/:id' do
    before { get "/api/v1/products/#{product_id}" }
    context 'when product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the product item' do
        expect(json['id']).to eq(product_id)
      end
    end

    context 'when product does not exist' do
      let(:product_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find product with 'id'=0")
      end
    end
  end

  describe 'POST /products/:id' do
    let!(:history) { create(:category) }
    let(:valid_attributes) do
      { title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops', 
        price: 200,
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        category_id: history.id 
      }
    end
    context 'when request attributes are valid' do
      before { post '/api/v1/products', params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/products', params: {} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'PUT /products/:id' do
    let(:valid_attributes) { { title: 'Mens Casual Premium Slim Fit T-Shirts' } }
    before { put "/api/v1/products/#{product_id}", params: valid_attributes }
    context 'when product exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'updates the product' do
        updated_item = Product.find(product_id)
        expect(updated_item.title).to match(/Mens Casual Premium Slim Fit T-Shirts/)
      end
    end
    context 'when the product does not exist' do
      let(:product_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find product with 'id'=0")
      end
    end
  end

  describe 'DELETE /products/:id' do
    before { delete "/api/v1/products/#{product_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
