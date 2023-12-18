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

  test 'render a new product form' do 
    get new_product_path 
    assert_response :success 
    assert_select 'form'
  end

  test 'allow to create a new product' do 
    post products_path, params: {
      product: {
        title: 'Nintendo 64',
        description: 'Faltan los cables',
        price: 400
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice],'Tu producto se ha creado correctamente'
  end

  test 'does not allow to create a new product with empty fields' do 
    post products_path, params: {
      product: {
        title: '',
        description: 'Faltan los cables',
        price: 400
      }
    }

    assert_response :unprocessable_entity
  end

end
