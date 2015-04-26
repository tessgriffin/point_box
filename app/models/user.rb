class User < ActiveRecord::Base
  attr_reader :password

  validates :email, uniqueness: true, presence: true
  validates :encrypted_password, presence: true
  validates :password, presence: true, if: :new_record?

  def password=(password)
    @password = password
    self.encrypted_password = BCrypt::Password.create(password)
  end

  def encrypted_password
    if super
      BCrypt::Password.new(super)
    end
  end

  def self.authenticate(params)
    user = find_by(email: params[:email])
    if user && user.encrypted_password == params[:password]
      return user
    end
  end
end