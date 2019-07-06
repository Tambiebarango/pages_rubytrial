require "test_helper"

class CategoryTest < ActiveSupport::TestCase

        def setup
            @category = Category.new(name: 'sports')
        end

        test "assert category name is valid" do
            assert @category.valid?
        end

        test "assert name cannot be empty" do
            @category.name = " "
            assert_not @category.valid?
        end

        test "assert name must be unique" do
            @category.save
            @category2 = Category.new(name: "sports")
            assert_not @category2.valid?
        end

        test "name not too long" do
            @category.name = "lalalalalalalalalalalalalalalalala"
            assert_not @category.valid?
        end

        test "name not too short" do
            @category.name = " a"
            assert_not @category.valid?
        end
end 
