# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  fname        :string(255)
#  lname        :string(255)
#  address1     :text(65535)
#  address2     :text(65535)
#  postcode     :string(255)
#  city         :string(255)
#  state        :string(255)
#  country      :string(255)
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :fname, :lname, :address1, :address2, :postcode, :city, :state, :country, :phone_number
  validates_numericality_of :postcode, length: { is: 5 }, allow_blank: true, :only_integer => true, :message => 'should only contain numbers.'
  validates           :phone_number, length: { in: 8..15 }, format: { with: /\A0[0-9\-\+ \/]*\z/ }, allow_blank: true, :numericality => true
end
