# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  order_number :string(255)
#  quantity     :integer
#  total_price  :decimal(8, 2)
#  status       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :payments, dependent: :destroy

  validates_presence_of :quantity

  default_scope -> { order('orders.created_at DESC') }
  scope :not_active, -> {where(status: "Pending")}

  after_initialize :set_default_status, if: :new_record?
  after_create :generate_order_number
  after_create :calculate_total_price

  def set_default_status
    self.status ||= "Pending"
  end

  def generate_order_number
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    order_number = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(:order_number => "#" + order_number)
  end

  def calculate_total_price
    fixed_price = 100
    total_price = self.quantity * fixed_price
    self.update(:total_price => total_price)
  end

  def is_pending?
    status === "Pending"
  end

  def is_active?
    status === "Active"
  end

  def is_cancel?
    status === "Cancel"
  end
end
