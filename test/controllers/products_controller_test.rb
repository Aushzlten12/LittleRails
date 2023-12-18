require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'render a list of products' do 
    get products_path 
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select '.title', 'PS4 fat'
    assert_select '.description', 'Buen Estado'
    assert_select '.price', '1600$'
  end

end
