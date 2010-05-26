class Chef
  def make(dish)
    puts "Chef: You don't want #{dish}! Try this:"
    :dish_of_the_day
  end
end

class Cook < Chef
  def make(dish)
    [super, :salad].join(' and ').tr('_', ' ')
  end
end

puts "Meal: " + Cook.new.make(:guinea_fowl_fricassee_with_foie_gras)
#=> Chef: You don't want guinea_fowl_fricassee_with_foie_gras! Try this:
# Meal: dish of the day and salad
