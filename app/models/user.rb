class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  validate :email_provides_correct_username
  after_create :create_username

  private

  def username_part
    email.slice(0..(email.index('@') - 1))
  end

  def email_provides_correct_username
    part = username_part
    if part.nil? || part.downcase.tr("^a-z", "").empty?
      errors.add(:email, "Valid username can not be constructed from the email")
    end
  end

  def create_username
    self.username = username_part.tr("^a-z", "")
    save!
  end
end
