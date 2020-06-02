require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves when all the fields are complete and correctly filled in" do
      @category = Category.new(:name => "Mugs")
      @product = Product.new(:name => "Cute Retro", :price => 55, :quantity => 20, :category => @category)

      expect(@product.save).to eql(true)
    end

    it "sets an error when name field is not filled in" do
      @category = Category.new(:name => "Mugs")
      @product = Product.new(:name => nil, :price => 55, :quantity => 20, :category => @category)
      
      expect(@product.save).to eql(false)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    #IGNORE FROM HERE
    it "sets an error when price field is not filled in" do
      @category = Category.new(:name => "Mugs")
      @product = Product.new(:name => "Cute Retro", :price => nil, :quantity => 20, :category => @category)

      expect(@product.save).to eql(false)
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "sets an error when quantity field is not filled in" do
      @category = Category.new(:name => "Mugs")
      @product = Product.new(:name => "Cute Retro", :price => 55, :quantity => nil, :category => @category)

      expect(@product.save).to eql(false)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "sets an error when category field is not filled in" do
      @product = Product.new(:name => "Cute Retro", :price => 55, :quantity => 20, :category => nil)

      expect(@product.save).to eql(false)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end