require 'terminal-table'

module Analyzable
  
  def average_price(products)
    sum = 0.0
    products.each do |product|
      sum = sum + product.price
    end
    (sum/products.length).round(2)
  end

  def print_report(products)
    output = summary_report(products) + detailed_report(products)
  end

  def count_by_brand(products)
    count = {products.first.brand => products.length}
  end

  def count_by_name(products)
    count = {products.first.name => products.length}
  end

  def summary_report(products)
    brands = products.map(&:brand).uniq
    names = products.map(&:name).uniq
    output = "\n" + stars + "Summary Report (start) " + stars + "\n"
    output = output + "\nAvg. price = $#{average_price(products)}\n"
    output = output + "\nInventory by Brand:\n"
    brands.each do |brand|
      count = count_by_brand(Product.where(brand: brand))[brand]
      output = output + "  - #{brand}: #{count}\n"
    end
    output = output + "\nInventory by Name:\n"
    names.each do |name|
      count = count_by_name(Product.where(name: name))[name]
      output = output + "  - #{name}: #{count}\n"
    end
    output = output + "\n" + stars + "Summary Report (end) " + stars + "\n\n\n"
    output
  end

  private

  def stars
    "*"*10
  end

  def detailed_report(products)
    rows = []
    products.each do |product|
      rows << [product.id, product.brand, product.name, product.price]
    end
    table = Terminal::Table.new :title => "Detailed Product Report",
        :headings => ['ID', 'Brand', 'Name', 'Price'],
        :rows => rows
    output = with_captured_stdout { puts table }
  end

  def with_captured_stdout
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

end
