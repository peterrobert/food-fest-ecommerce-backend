require_relative '../../../representers/product_representer.rb'

module Api
    module V1
        class ProductsController < ApplicationController
            before_action :set_product, only: %i[update show destroy]
            
            def index
              @products = Product.all
              render json: ProductsRepresenter.new(@products).as_json
            end
            def create
              @product = Product.create(product_params)
              if @product.save
                render json: ProductRepresenter.new(@product).as_json, status: :created
              else
                render json: @product.errors, status: :unprocessable_entity
              end
            end
           
            def show
              render json: ProductRepresenter.new(@product).as_json
            end

            def update
              @product.update(product_params)
              head :no_content
            end

            def destroy
              @product.destroy
              head :no_content
            end

            private

            def product_params
              params.permit(:title, :price, :description, :image, :category_id)
            end

            def set_product
              @product = Product.find(params[:id])
            end
        end

    end
end