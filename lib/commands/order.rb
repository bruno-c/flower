MEALS = %w(meal chicken beef brochette food)
SALAD = %w(salad salade)

class Order < Flower::Command	
	respond_to %w(order command ready)

	def ordered_meal(message)
		MEALS.find { |meal|
			message[meal]
		}
	end

	def ordered_salad(message)
		SALAD.find { |meal|
			message[meal]
		}
	end

	def self.respond(command, message, sender, flower)
		flower.say "Ok @#{sender[:nick]}, I'm going to order #{ordered_meal || ordered_salad} for you."
	end

	def self.description
		"Order from freshmint"
	end
end
