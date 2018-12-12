class User < ActiveRecord::Base
  require "common_method.rb"  
  include CommonMethod

  before_create :gen_id
  after_create_commit :welcome_user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :wanteds, dependent: :destroy
  has_and_belongs_to_many :matcheds

  private

  def gen_id
    randomise_id(self.class)
  end

  def welcome_user
    UserMailer.welcome_email(self).deliver_later!
  end

end
