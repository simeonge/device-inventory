class Device < ActiveRecord::Base
  has_one :status, :foreign_key => :code
  has_many :histories
  validates :os, :model, :code, presence: true
  validates :code, uniqueness: true
end
