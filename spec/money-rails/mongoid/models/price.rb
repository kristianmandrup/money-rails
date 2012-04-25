class Price
	include Mongoid::Document
  monetizable_orm :mongoid, :as => :priced

  # embedded_in :priced, :polymorphic => true

  def self.for amount, currency = nil
  	currency = ::Money::Currency.new(currency || ::Money.default_currency)
  	money = Money.new(amount, currency)
  	MoneyRails::Moneys.price_class.new :price => money
  end
end
