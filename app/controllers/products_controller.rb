class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!


  # GET /products
  # GET /products.json
  def index
    @products = Product.all    

    if params.has_key?(:code)
      @code = params[:code]
      @products.delete_if {|prod| !prod.getStringCode.include? @code.to_s}
    end  

    if params.has_key?(:desc)
      @desc = params[:desc]
      @products.delete_if {|prod| !prod.description.include? @desc}
    end

    if params.has_key?(:orig)
      @orig = params[:orig]
      @products.delete_if {|prod| !prod.original_code.include? @orig}
    end

    
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @nextCodeDais = Product.getNextCode("1")
    @nextCodeArcre = Product.getNextCode("2")
    @nextCodeArmand = Product.getNextCode("3")

    products = Product.all
    @autocomplete_codes = Array.new

    products.each do |prod|
      @autocomplete_codes.push prod.product
    end
  end

  # GET /products/1/edit
  def edit
    @nextCode = @product.product.to_i
    @origiinalCode = @product.original_code
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    @product.send('verifyDigit=' ,@product.getVerifyDigit)
    
    unique = true;

    #products = Product.where(:product => @product.product)
    #if products.count > 1
     # products.each do |productT| 
      #  if productT.codeText.eql? @product.codeText
       #   unique = false;
        #end
     # end
    #end

    respond_to do |format|
      if unique 
        if @product.save
          format.html { redirect_to @product, notice: 'El producto se ha creado exitosamente.' }
          format.json { render action: 'show', status: :created, location: @product }
        else
          flash[:notice] = 'Error al ingresar el producto, por favor intentelo nuevamente.'
          format.html { render action: 'new'}
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        flash[:notice] = 'No puede repetir el codigo del producto.'
        format.html { render action: 'new'}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'El producto se ha actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', notice: 'Error al actualizar.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:country, :original_code, :enterprise, :description, :product, :verifyDigit,:code,:desc, :orig, :dais, :arcre, :armand, :filter)
    end
end
