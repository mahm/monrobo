class Mon
  # Mon Generate
  class << self
    PARTS_POSITIONS = {
      "01body"   => [0, 0],
      "02sideL"  => [-40, 0],
      "03sideR"  => [43, 0],
      "04crown"  => [0, -50],
      "05center" => [-3, 10],
      "06ribon"  => [0, 40]
    }.freeze
    def generate(parts = {})
      result = Magick::Image.new(250, 250) do
        self.background_color = "white"
        self.format = "png"
      end
      parts.each do |k, v|
        param = Mon::Param.new(k, v)
        next unless param.valid?
        coord = PARTS_POSITIONS[k.to_s]
        image = Magick::Image.from_blob(File::read(path(param.pos).join(param.filename))).first
        image = image.level_colors(param.color, "white") if param.color.present?
        result = result.composite(image, Magick::CenterGravity, coord.first, coord.last, Magick::OverCompositeOp)
      end
      result.to_blob
      # uuid = SecureRandom::uuid
      # Dir::mkdir(TMP_ROOT.join(uuid))
      # result.write(TMP_ROOT.join(uuid, 'out.png'))
      # Pathname.new('public').join(uuid, 'out.png')
    end

    PARTS_ROOT = Rails.root.join('app', 'assets', 'images', 'parts')
    def path(pos)
      PARTS_ROOT.join(pos)
    end

    # TMP_ROOT = Rails.root.join('public')
  end

  class Param
    attr_reader :pos, :filename, :color
    def initialize(pos, value)
      @pos = pos
      @filename = value[:file]
      @color = value[:color]
    end

    def valid?
      @pos.present? && @filename.present?
    end
  end

  # Material List
  class << self
    ASSET_PATH = Pathname.new('app').join('assets', 'images')
    RELATIVE_PARTS_ROOT = ASSET_PATH.join('parts')
    LISTS = {
      body_list:   "01body",
      side_l_list: "02sideL",
      side_r_list: "03sideR",
      crown_list:  "04crown",
      center_list: "05center",
      ribon_list:  "06ribon",
    }.freeze
    LISTS.each do |k, v|
      define_method "#{k}" do
        image_list(v)
      end
    end
    def image_list(pos)
      Dir::glob(RELATIVE_PARTS_ROOT.join(pos).join('*.gif')).map do |filepath|
        filepath.gsub!("#{ASSET_PATH.to_s}/", "")
      end
    end
  end
end
