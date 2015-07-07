# == Schema Information
#
# Table name: payments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  order_id         :integer
#  payment_method   :string(255)
#  payment_date     :string(255)
#  payment_time     :string(255)
#  reference_number :string(255)
#  total_payment    :decimal(8, 2)
#  attachment       :string(255)
#  receipt_number   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :string(255)
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#  index_payments_on_user_id   (user_id)
#

class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  mount_uploader :attachment, AttachmentUploader

  validates_presence_of :order_id, :payment_method, :payment_time, :payment_date, :reference_number, :total_payment, :attachment

  after_initialize :set_default_status, if: :new_record?
  after_create :generate_receipt_number
  after_update :update_order_status

  default_scope -> { order('payments.created_at DESC') }

  def set_default_status
    self.status ||= "Pending"
  end

  def generate_receipt_number
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    receipt_number = (0...4).map { random[rand(random.length)] }.join
    self.update_attributes(:receipt_number => "#WS-P" + receipt_number)
  end

  def update_order_status
    if self.status === "Accepted"
      self.order.update_attributes(status: "Active")
    elsif self.status === "Pending"
      self.order.update_attributes(status: "Pending")
    else
      self.order.update_attributes(status: "Pending")
    end
  end

  def is_pending?
    status === "Pending"
  end

  def is_accepted?
    status === "Accepted"
  end

  def is_rejected?
    status === "Rejected"
  end
end
