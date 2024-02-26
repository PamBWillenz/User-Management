class Employee < ApplicationRecord
    validates :first_name, :last_name, :email, :contact_number, :date_of_birth, :date_of_hiring, presence: true
    validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates :contact_number, format: { with: /\d{10}/, message: "must be a 10-digit phone number" }

    # Additional validations for date_of_birth and date_of_hiring
    # validates :date_of_birth, custom_validation_method_for_date
    # validates :date_of_hiring, custom_validation_method_for_date

    # Other attributes
    # validates :pincode, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    #  allow_blank: true
    # validates :city, :state, length: { maximum: 255 }, allow_blank: true
end
