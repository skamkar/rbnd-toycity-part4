require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed

  ids = [1,2,3,4,5,6,7,8]
  names = ["Aerodynamic Concrete Bag", "Gorgeous Bronze Bag", "Rustic Bronze Pants", "Synergistic Cotton Bag", "Heavy Duty Wooden Bag", "Orchid Plant", "Gorgeous Concrete Pants", "Incredible Paper Car", "Awesome Bronze Table"]
  brands = ["Lakin Group", "Miller and Sons", "Langosh-Jerde", "Johnson and Sons", "Weber Group", "ColtToys","Bergstrom Inc","Kling and Sons","Mitchell, Rowe and Gottlieb"]
  prices = [56.35, 29.72, 74.79, 63.73, 90.08, 2.0, 23.15, 57.49, 9.41]

  ids.length.times do |i|
    Product.create( id: ids[i],
                    brand: brands[i],
                    name: names[i],
                    price: prices[i] )
  end
end
