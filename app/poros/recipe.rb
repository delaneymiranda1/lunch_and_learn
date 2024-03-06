class Recipe
  attr_reader :id, :type, :title, :url, :image

  def initialize(data)
    @id = nil
    @type = 'recipe'
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @image = data[:recipe][:image]
  end
end