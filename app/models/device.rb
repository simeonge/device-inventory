class Device < ActiveRecord::Base

  validates :os, :model, :code, presence: true
  validates :code, uniqueness: true
end
