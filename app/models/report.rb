# coding: utf-8
class Report
  include Mongoid::Document
  include Mongoid::BaseModel
  include Mongoid::Timestamps

  field :content
  field :ip

  belongs_to :article
  counter_cache :name => :reply, :inverse_of => :reports

end