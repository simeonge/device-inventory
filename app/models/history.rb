class History < ActiveRecord::Base
  belongs_to :device
  validates :code, :holder, :timeout, :timein, presence: true
end
