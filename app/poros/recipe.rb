class Recipe
  attr_reader :id, :type, :title, :url, :image

  def initialize(data)
    @id = nil
    @type = 'recipe'
    @title = data[:title]
    @url = data[:url]
    @image = data[:image]
  end
end