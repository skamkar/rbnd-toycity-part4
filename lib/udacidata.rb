require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  $DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes=nil)
    product = self.new(attributes)
    CSV.open($DATA_PATH, "a") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
    end
    return product
  end

end

