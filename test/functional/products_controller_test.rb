require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    login_admin
    @product = create(:product)
    @request.session[:last_seen] = Time.now
  end

  test "should get index" do
    1.times do
      create(:product)
    end
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: {  }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: {  }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "individuals with reader access should not be able to create products" do

    login_reader
    product_count = Product.count

    post :create, product: { }

    assert_equal(Product.count, product_count)

  end

  test "editors should be able to create products" do

    login_editor
    assert_difference('Product.count') do
        post :create, product: {  }
    end

  end

  test "editors should be able to destroy products" do
    login_editor
    assert_difference('Product.count', -1) do
          delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "individuals with reader access should not be able to destroy products" do
    login_reader
    product_count = Product.count
    delete :destroy, id: @product

    assert_equal(Product.count, product_count)

  end

  test "individuals with reader access should not be able to view products" do

    login_reader
    get :index

    assert :redirect
  end

end
