require 'test_helper'

class ProductClassesControllerTest < ActionController::TestCase
  setup do
    @product_class = product_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_class" do
    assert_difference('ProductClass.count') do
      post :create, product_class: { className: @product_class.className }
    end

    assert_redirected_to product_class_path(assigns(:product_class))
  end

  test "should show product_class" do
    get :show, id: @product_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_class
    assert_response :success
  end

  test "should update product_class" do
    put :update, id: @product_class, product_class: { className: @product_class.className }
    assert_redirected_to product_class_path(assigns(:product_class))
  end

  test "should destroy product_class" do
    assert_difference('ProductClass.count', -1) do
      delete :destroy, id: @product_class
    end

    assert_redirected_to product_classes_path
  end
end
