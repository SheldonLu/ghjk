# coding: utf-8
class Article
  include Mongoid::Document
  include Mongoid::BaseModel
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  include Mongoid::Likeable

  # 内容
  field :content
  # 标签
  field :tags
  field :picture
  field :music
  field :video
  # 是否禁止评论
  #field :disable_reply, :type => Boolean, :default => false
  # 是否匿名发布
  field :anonymous_public, :type => Boolean, :default => false

  # 评论数 统计
  has_many :replies, :dependent => :destroy
  field :replies_count, :type => Integer, :default => 0

  # TODO :inverse_of => :articles 这个什么意思？？
  belongs_to :user, :inverse_of => :articles
  counter_cache :name => :user, :inverse_of => :articles

  scope :high_likes, desc(:likes_count, :_id)
  scope :high_replies, desc(:replies_count, :_id)
  scope :no_reply, where(:replies_count => 0)
  scope :popular, where(:likes_count.gt => 5)
  
end