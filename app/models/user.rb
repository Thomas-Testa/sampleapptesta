class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :username, presence: true, length: { maximum: 25 }

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255},
                            format: { with: VALID_EMAIL_REGEX},
                            uniqueness: {case_sensetive: false}
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}                            
    
    def User.digest(string) 
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                       BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def activate
        update_columns(activated: FILL_IN,activated_at: FILL_IN)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def remember 
        self.remember_token= User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest,nil)
    end

class << self
    def new_token
        SecureRandom.urlsafe_base64
    end

    def digest(string)
        cost=ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Password.create(string, cost: cost)
    end
end

private 

def downcase_email
    self.email = email.downcase
end

def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
end








end
