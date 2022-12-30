class ProductRepresenter

    def initialize(product)
      @product = product
    end

    def as_json
      {     
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        image: product.image,
        category: Category.find(product.id).name,
        date_added: book.created_at
      }
    end

    private

    attr_reader :product
end
   # app/representers/products_respresenter.rb

 class ProductsRepresenter
    def initialize(products)
      @products = products
    end 
    
    def as_json
      @products.map do |product|
        {
         
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          image: product.image,
          category: Category.find(product.id).name,
          date_added: book.created_at
        }
      end
    end

    private
    attr_reader :products

  end