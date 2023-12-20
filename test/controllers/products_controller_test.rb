require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'render a list of products' do 
    get products_path 
    assert_response :success
    assert_select '.product', 3
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select '.title', 'PS4 fat'
    assert_select '.description', 'Buen Estado'
    assert_select '.price', '1200$'
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
        price: 400,
        category_id: categories(:videogames).id
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

  test 'render an edit product form' do 
    get edit_product_path(products(:ps4))

    assert_response :success 
    assert_select 'form'
  end

  test 'allow to update a product' do 
    patch product_path(products(:ps4)), params: {
      product: {
        price: 165
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice],'Tu producto se ha actualizado correctamente'
  end

  test 'does not allow to update a product' do 
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
    end

    test 'can delete products' do
      assert_difference('Product.count',-1) do 
        delete product_path(products(:ps4)) 
      end
      assert_redirected_to products_path
      assert_equal flash[:notice],'Tu producto se ha eliminado correctamente'
    end
end
