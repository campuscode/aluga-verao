class PriceRangesController < ApplicationController

  def index
    find_property
    @price_ranges = @property.price_ranges.all
  end

  def show
    @price_range = PriceRange.find(params[:id])
  end

  def new
    find_property
    @price_range = PriceRange.new
  end

  def create
    find_property
    @price_range = @property.price_ranges.create(price_range_params)
    if @price_range.valid?
      redirect_to @price_range
    else
      flash[:error] = 'Houve um erro ao tentar cadastrar o preço por periodo'
      render :new
    end
  end

  def edit
    @price_range = PriceRange.find(params[:id])
  end

  def update
    @price_range = PriceRange.find(params[:id])
    @price_range.update(price_range_params)
    if @price_range.valid?
      redirect_to @price_range
    else
      flash[:error] = 'Houve um erro ao tentar editar o preço por periodo'
      render :edit
    end
  end

  private
  def price_range_params
    params.require(:price_range).permit(:start_date, :end_date, :daily_rate)
  end

  def find_property
    @property = Property.find(params[:property_id])
  end

end
