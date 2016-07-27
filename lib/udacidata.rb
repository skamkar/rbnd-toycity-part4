require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  @@all = []

  def self.create(attributes=nil)
    unless self.duplicate?(attributes)
      item = self.new(attributes)
      @@all.push(item)
      CSV.open(@@data_path, "a") do |csv|
        csv << [item.id, item.brand, item.name, item.price]
      end
      return item
    end
  end

  def self.all
    @@all
  end

  def self.all=(arg)
    @@all = arg
  end

  def self.first(n=1)
    if n == 1
      @@all.first
    else
      @@all.first(n)
    end
  end

  def self.last(n=1)
    if n == 1
      @@all.last
    else
      @@all.last(n)
    end
  end

  def self.find(id)
    if @@all.map(&:id).include?(id)
      @@all.select {|item| item.id == id}.first
    else
      raise ProductNotFoundError, "Product id of #{id} cannot be found."
    end
  end

  def self.destroy(id)
    if @@all.map(&:id).include?(id)
      rm_index = @@all.map(&:id).index(id)
      rm_item = @@all.delete_at(rm_index)
      self.rewrite_file
      rm_item
    else
      raise ProductNotFoundError, "Product id of #{id} cannot be destroyed, because it cannot be found."
    end
  end

  def self.where(query)
    type = query.keys.first
    value = query.values.first
    matching_indices = @@all.each_index.select{|item| @@all[item].send(type) == value}
    matches = []
    matching_indices.each{|index| matches << @@all[index]}
    matches
  end

  def update(new_info)
    new_info.each do |type, value|
      code = ":@" + type.to_s
      self.instance_variable_set(eval(code), value)
    end
    self.class.rewrite_file
    self
  end

  def self.rewrite_file
    CSV.open(@@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
      @@all.each do |item|
        csv << [item.id, item.brand, item.name, item.price]
      end
    end    
  end

  def self.duplicate?(attributes)
    @@all.each do |item|
      if (item.id == attributes[:id])
        return true
      end
    end
    false
  end
end

