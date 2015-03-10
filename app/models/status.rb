class Status < ActiveRecord::Base
  belongs_to :devices, :foreign_key => :code
  validates :code, presence: true
end
