# Thanks to: https://gist.github.com/840500

module MoneyRails
	module MongoMapper
		module Monetizable
			def self.included(base)
				base.class_eval do
				  key :price_pence, 	Integer, :default => 0
				  key :currency_iso, 	String,  :default => Money.default_currency.iso_code
				  
				  validates_numericality_of :price_pence
				end
			end
			  
		  # Virtual price / currency attributes
		  
		  def price
		    Money.new(self.price_pence, currency)
		  end
		  def price=(price)
		    self.price_pence = price.cents
		  end

		  def currency
		    Money::Currency.new(currency_iso)
		  end	
		end
	end
end