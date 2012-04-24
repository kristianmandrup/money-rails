module MoneyRails
	module Orm
		module Macros
			def self.included(base)
				base.extend ClassMethods
			end

			module ClassMethods
				def set_money_orm orm = :mongoid
					case orm.to_sym
					when :mongoid
						self.send :include, Mongoid::Document
					else
						self.send :include, MongoMapper::Document
					end
				end					

				def monetize_orm orm = :mongoid
					if [:mongoid, :mongo_mapper].include? orm.to_sym					
						self.send :include, "MoneyRails::#{orm.to_s.camelize}::Monetize".constantize
						set_money_orm orm
					else
						raise ArgumentError, "ORM #{orm} has no money macro support yet"
					end
				end

				def monetizable_orm orm = :mongoid
					if [:mongoid, :mongo_mapper].include? orm.to_sym					
						self.send :include, "MoneyRails::#{orm.to_s.camelize}::Monetizable".constantize
						set_money_orm orm
					else
						raise ArgumentError, "ORM #{orm} has no money macro support yet"
					end
				end
			end
		end
	end
end