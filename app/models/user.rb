# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string
#  last_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #validations
        before_create :capitalize_name
      has_many :events, dependent: :destroy
       


      def full_name 
         return "#{self.name} #{self.last_name}"
      end

      private 
      def capitalize_name 
         self.name = self.name.capitalize
         self.last_name = self.last_name.capitalize
      end
end
