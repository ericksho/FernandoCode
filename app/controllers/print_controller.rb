class PrintController < ApplicationController
	before_filter :authenticate_user!
  def select
  	@codeCount = 3#12

    products = Product.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    products.each do |product|
      c = product.getStringCode
      @autocomplete_codes.push c
      
    end
  end

  def sheet
  	@codes = Array.new
  	@codes.push 'NOT'
  	@codeCount = params['codeCount'].to_i
  	for i in 1..@codeCount
  		codeT = 'code_' + i.to_s
  		@codes.push params[codeT]
  	end
  end

  def selectSamples
    @codeCount = 6

    products = Product.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    products.each do |product|
      c = product.getStringCode
      @autocomplete_codes.push c      
    end
  end

  def sheetSample
    @codes = Array.new
    @codes.push 'NOT'
    @codeCount = params['codeCount'].to_i
    for i in 1..@codeCount
      codeT = 'code_' + i.to_s
      @codes.push params[codeT]
    end

    products = Product.all
    @description = Array.new
    products.each do |product|
      index = @codes.index(product.getStringCode)
      if index != nil
        @description.insert(index, product.description)  
      end
    end

  end

end
