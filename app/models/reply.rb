# coding: utf-8
class Reply
  include Mongoid::Document
  include Mongoid::BaseModel
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  include Mongoid::SoftDelete
  include Mongoid::Likeable

  field :content
  # 禁止显示
  field :disable_show, type:Boolean, :default => false

  belongs_to :user, :inverse_of => :replies
  belongs_to :article, :inverse_of => :replies

  counter_cache :name => :user, :inverse_of => :replies
  counter_cache :name => :article, :inverse_of => :replies

  attr_accessible :content

  validates_presence_of :content


end