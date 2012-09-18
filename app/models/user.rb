#encoding: utf-8

require "digest/md5"

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  field :email_md5

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

  validates_presence_of :login, :email
  validates_uniqueness_of :login, :email, :case_sensitive => false

  index :login => 1
  index :email => 1
  index :location => 1

  attr_accessor :password_confirmation
  attr_accessible :login, :location, :tagline, :avatar, :password, :password_confirmation

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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({:login => /^#{Regexp.escape(login)}$/i}, {:email => /^#{Regexp.escape(login)}$/i}).first
    else
      super
    end
  end

  def email=(val)
    self.email_md5 = Digest::MD5.hexdigest(val || "")
    self[:email] = val
  end

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

  # 注册邮件提醒
  after_create :send_welcome_mail
  def send_welcome_mail
    # TODO
    #UserMailer.delay.welcome(self.id)
  end

  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end

  def self.find_by_email(email)
    where(:email => email).first
  end


end
