class GenerateParameter < ActiveRecord::Base
  attr_accessible :data
  serialize :data, Hash
  before_create :normalize_for_use
  def normalize_for_use
    self.data = self.data.values.map do |elem|
      { elem["pos"] => { file: null2nil(elem["file"]), color: null2nil(elem["color"]) } }
    end.compact.inject(Hash.new) { |result, elem| result.merge! elem }
    logger.info self.data
  end

  def null2nil(elem)
    return nil if elem == "null"
    elem
  end

  def self.clean
    GenerateParameter.where("created_at < ?", 1.days.ago).delete_all
  end
end
