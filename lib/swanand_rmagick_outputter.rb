module Barby
  class SwanandRmagickOutputter < RmagickOutputter
    register :to_jpg_2

    def to_jpg_2(*a)
      to_blob('jpg', *a)
    end
  
    #Returns a string containing a JPEG image
    def to_blob(format, *a)
      img = to_image(*a)
      add_text(img)
      blob = img.to_blob{|i| i.format = format }
    
      #Release the memory used by RMagick explicitly. Ruby's GC
      #isn't aware of it and can't clean it up automatically
      img.destroy! if img.respond_to?(:destroy!)
    
      blob
    end
  
    def add_text(canvas)
      text = Magick::Draw.new
      text.font_family = 'Courier'
      text.pointsize = 14
      text.gravity = Magick::SouthGravity
      text.undercolor = 'white'
      text.font_stretch = Magick::ExtraExpandedStretch
    
      text.annotate(canvas, 0, 0, 0, 8, " #{barcode.data} ")
      canvas
    end
  end
end