class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates_presence_of :address,
                        :city,
                        :state,
                        :zip

  enum use: ['default', 'home', 'business', 'other']
end
