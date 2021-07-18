class ProductsController < AuthenticationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t('.success')
      redirect_to @product
    else
      flash[:notice] = t('.fail')
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:sku)
  end
end
