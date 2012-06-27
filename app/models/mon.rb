# require 'RMagick'

class Mon
  PARTS_ROOT = Rails.root.join('app', 'assets', 'images', 'parts')

  PARTS_POSITIONS = {
    "01body"   => [0, 0],
    "02sideL"  => [-40, 0],
    "03sideR"  => [43, 0],
    "04crown"  => [0, -50],
    "05center" => [-3, 10],
    "06ribon"  => [0, 40]
  }.freeze

  class << self
    def generate(parts = {})
      result = Magick::Image.new(250, 250)
      parts.each do |k, v|
        param = Mon::Param.new(k, v)
        coord = PARTS_POSITIONS[k.to_s]
        image = Magick::Image.from_blob(File::read(path(param.pos).join(param.filename))).first
        image = image.color_floodfill(0, 0, param.color) if param.color.present?
        result = result.composite(image, Magick::CenterGravity, coord.first, coord.last, Magick::OverCompositeOp)
      end
      result.write(Rails.root.join('out.png'))
    end

    def path(pos)
      PARTS_ROOT.join(pos)
    end
  end

  class Param
    attr_reader :pos, :filename, :color
    def initialize(pos, values)
      @pos = pos
      @filename = values.first
      @color = values.last
    end
  end
end
