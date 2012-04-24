require 'spec_helper'

# Require dummy Rails app
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

describe MoneyRails::ActiveRecord::Monetizable do

  describe "monetize" do
    before :each do
      @product = Product.create(:price_cents => 3000, :discount => 150,
                                :bonus_cents => 200)
    end

    it "attaches a Money object to model field" do
      @product.price.should == Money.new(3000)
    end

    it "respects :target_name argument" do
      @product.discount_value.should == Money.new(150)
    end

    it "overrides table currency with a field specific" do
      @product.bonus.currency.should == Money::Currency.find(:eur)
    end
  end
end
