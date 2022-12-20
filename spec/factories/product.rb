FactoryBot.define do
    factory :product do
      title {"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"}
      price  {109.95}
      category { create(:category) }
      image  {"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"}
      description {"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday"}
    end
end