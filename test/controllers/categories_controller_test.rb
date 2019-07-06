require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest

    def setup
        @category = Category.create(name:"sports")
    end

    test "get index page" do
        get categories_path
        assert_response :success
    end

    test "get show page" do
        get category_path(@category)
        assert_response :success
    end

    test "new category" do
        get new_category_path
        assert_response :success
    end



end
