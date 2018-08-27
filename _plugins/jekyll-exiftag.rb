# -*- coding: utf-8 -*-
# A LiquidTag to get Exif Tags using EXIFR
# by: Beni Buess
#
#
# Usage:
#
# {% exiftag tagname,[source],[file] %}
#
# Everything given as tagname is called on EXIFR::JPEG, so this could be model oder f_number.to_f (see https://github.com/remvee/exifr)
# If you give a source, this source is used build the fullpath for the given file (you can also configure them in _config.yml, see below)
# If the file is given, this is the file to get Exif Tags for, this can be alternatively defined in the YAML Front Matter as img: file
#
#
# Configuration:
#
# Put this in your _config.yml
#
# exiftag:
#  sources:
#    - photos
#    - photos/other_source
#
# These paths are relative to your sites root. Don't add leading and trailing slashes.
#

require 'exifr/jpeg'

module Jekyll
  class ExifTag < Liquid::Tag
    def initialize(tag_name, params, token)
      super
      @args = self.split_params(params)
    end

    def render(context)
      source = *context.registers[:site].config['exif-source']
      
      # first param is the exif tag
      tag = @args[0]
      category = @args[1]
      filename = @args[2]

      path = File.join(source, category, filename)

      img = Liquid::Template.parse(path).render context

      exif = EXIFR::JPEG::new(img)

      begin 
        return tag.split('.').inject(exif){|o,m| o.send(m)}
      rescue
        "error"
      end
    end

    def split_params(params)
      params.split(",").map(&:strip)
    end
  end
end

Liquid::Template.register_tag('exiftag', Jekyll::ExifTag)
