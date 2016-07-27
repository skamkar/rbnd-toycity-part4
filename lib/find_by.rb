class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      find_by = %Q{
        def find_by_#{attribute}(argument)
          self.all().select{|item| item.#{attribute} == argument}.first
        end
      }
      class_eval(find_by) 
    end
  end
  create_finder_methods :brand, :name, :price
end