class User < ApplicationRecord
  has_many :books
  has_many :list
  
  validates :role, acceptance: { accept: ['Writer', 'Reader'], message: "Must be 'Writer' or 'Reader'" }
  validates :name, presence: true, length: {minimum: 2, message: "Must be 2 or more sym"}
  validates :surname, presence: true, length: {minimum: 2, message: "Must be 2 or more sym"}
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, 
          :registerable,
          :recoverable, 
          :rememberable, 
          :validatable

  after_create :send_welcome

  private
  def send_welcome
    HelloWorldMailer.with(user: self).welcome.deliver_now
  end
  
end