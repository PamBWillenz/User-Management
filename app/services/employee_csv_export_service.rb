require 'csv'

class EmployeeCsvExportService
  def initialize(objects)
    @objects = objects 
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_headers

      @objects.each do |object|
        csv << csv_row(object)
      end
    end
  end

  private_methods

  def csv_headers
    @objects.first.attributes.keys # Extracting keys from the first object's attributes
  end

  def csv_row(object)
    object.attributes.values # Extracting values from the object's attributes
  end
end