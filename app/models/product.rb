class Product < ActiveRecord::Base

	def self.getNextCode(enterprise)
	    products = Product.where("enterprise = " + enterprise)
	    codes = Array.new

	    products.each do |prod|
	      codes.push prod.product
	    end

		i2 = codes.max
		if i2.nil?
			i2 = 0;
		end

	    for i in 0..i2
	    	unless codes.include? i
	    		return i
	    	end
	    end

	    i2 + 1
	end

	def getEnterprise
		ent = ''
		case self.enterprise
		when 1
			ent = 'Francisco'
		when 2
			ent = 'Francisco2'
		when 3 
			ent = 'Francisco3'
		end
		ent
				
				
	end

	def getBarcode

		barcode_value = self.getArrayCode.join
		# coding: utf-8
 
		require 'rubygems'
		require 'RMagick'
		require 'rmagick'
		require 'chunky_png/rmagick'
		 
		# Load libraries of barby.
		require 'barby'
		require 'barby/barcode/ean_13'
		require 'barby/outputter/png_outputter'
		require 'barby/outputter/rmagick_outputter'
		 
		barcode =Barby::EAN13.new(barcode_value)

		png = barcode.to_png(:margin => 5, :xdim => 3, :height => 130)
		img = png.to_yaml.gsub('--- !binary |-','')

		imglist = Magick::Image.from_blob(png)
    	imgm = imglist.first

    	text = Magick::Draw.new
		text.font_family = 'Courier'
		text.pointsize = 28	
		text.gravity = Magick::SouthGravity
		text.undercolor = 'white'
		text.font_stretch = Magick::ExtraExpandedStretch

		text.annotate(imgm, 0, 0, 0, 10, ' ___________ ')
		text.annotate(imgm, 0, 0, 0, 4, self.getStringCode)

		png = imgm.to_blob{|i| i.format = 'png' }

		img = png.to_yaml.gsub('--- !binary |-','')
	end


	def getStringCode
		(getArrayCode+[self.getVerifyDigit]).join
	end

	def getArrayCode
		country = self.country.to_s.scan(/\d/).map { |x| x.to_i }
		enterprise = self.enterprise.to_s.scan(/\d/).map { |x| x.to_i }
		product = self.product.to_s.scan(/\d/).map { |x| x.to_i }

		case country.count
		when 2
			country = [0] + country 
		when 1
			country = [0,0] + country
		end

		case enterprise.count
		when 3
			enterprise = [0] + enterprise 
		when 2
			enterprise = [0,0] + enterprise
		when 1 
			enterprise = [0,0,0] + enterprise
		end

		case product.count
		when 4
			product = [0] + product 
		when 3
			product = [0,0] + product
		when 2 
			product = [0,0,0] + product
		when 1 
			product = [0,0,0,0] + product
		end

		digits = country + enterprise + product
	end
	
	def getVerifyDigit 

		digits = self.getArrayCode

		evenSum = digits.values_at(* digits.each_index.select{|i| i.even?}).inject{|sum,x| sum + x }

		oddSum = digits.values_at(* digits.each_index.select{|i| i.odd?}).inject{|sum,x| sum + x } * 3

	    sum = evenSum + oddSum
	    
	    mod = 10 - sum % 10
	    mod==10 ? 0 : mod
	end

end
