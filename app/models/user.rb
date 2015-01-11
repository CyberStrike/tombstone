class User < ActiveRecord::Base
  has_many :wallets, dependent: :destroy
  has_one :claim, dependent: :destroy
  has_one :preference

  # Use friendly_id on Users
  extend FriendlyId
  friendly_id :friendify, use: :slugged
  
  # necessary to override friendly_id reserved words
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "#{username}"
    end
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  # Pagination
  paginates_per 100
  
  # Validations
  # :username
  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: "can only contain letters and digits"
  validates :username, length: { in: 4..15 }
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def self.paged(page_number)
    order(admin: :desc, username: :asc).page page_number
  end
  
  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, username: :asc
      ).page page_number
    else
      order(admin: :desc, username: :asc).page page_number
    end
  end
  
  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","username","slug","created_at")
  end
  
  def self.last_signins(count)
    order(last_sign_in_at: 
    :desc).limit(count).select("id","username","slug","last_sign_in_at")
  end
  
  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end

  def create_key_pairs
    keypair = EncryptoSigno.generate_keypair
    private_key = keypair.to_s
    public_key  = keypair.public_key.to_s

    #signing of private key
    token = SecureRandom.base64
    signature = EncryptoSigno.sign(private_key, token)

    sig_join = signature.split.join
    signature_by_2 = (sig_join.size / 2)

    user1_key = sig_join[0..signature_by_2]
    user2_key = sig_join[(signature_by_2 + 1)..sig_join.size]

    self.update(private_key:private_key, public_key:public_key, token:token, user1_key:user1_key, user2_key:user2_key)
  end

  def destroy_key_pairs
    self.update(private_key:nil, public_key:nil, token:nil, user1_key:nil, user2_key:nil)
  end


end
