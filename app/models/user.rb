class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :login
  # 城市
  field :location
  field :state, :type => Integer, :default => 1
  # 签名
  field :tagline

  field :articles_count, :type => Integer, :default => 0
  field :replies_count, :type => Integer, :default => 0

  mount_uploader :avatar, AvatarUploader

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  has_many :articles, :dependent => :destroy
  has_many :replies, :dependent => :destroy

  # 是否是管理员
  def admin?
    Setting.admin_emails.include?(self.email)
  end

  # 是否有 Wiki 维护权限
  def wiki_editor?
    self.admin? or self.verified == true
  end

  def has_role?(role)
    case role
      when :admin then admin?
      when :wiki_editor then wiki_editor?
      when :member then true
      else false
    end
  end


end
