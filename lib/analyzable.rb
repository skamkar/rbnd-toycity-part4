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
    rows = []
    products.each do |product|
      rows << [product.id, product.brand, product.name, product.price]
    end
    table = Terminal::Table.new :title => "Product Report",
        :headings => ['ID', 'Brand', 'Name', 'Price'],
        :rows => rows
    output = with_captured_stdout { puts table }
  end

  def count_by_brand(products)
    count = {products.first.brand => products.length}
  end

  def count_by_name(products)
    count = {products.first.name => products.length}
  end

  private

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
