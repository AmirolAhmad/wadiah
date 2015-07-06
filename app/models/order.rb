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

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= "Pending"
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
