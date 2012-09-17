class Tag
  include Mongoid::Document
  include Mongoid::BaseModel

  # 标签内容
  field :name
  # 统计数量
  field :count
end
