class Spree::WholesalersController < Spree::BaseController
  respond_to :html, :xml

  def index
  end

  def show
    @wholesaler = Spree::Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end

  def new
    @wholesaler = Spree::Wholesaler.new
    @wholesaler.build_user
    @wholesaler.bill_address = Spree::Address.default
    @wholesaler.ship_address = Spree::Address.default
    respond_with(@wholesaler)
  end

  def create
    @wholesaler = Spree::Wholesaler.new(params[:wholesaler])
    if @wholesaler.save
      flash[:notice] = I18n.t('spree.wholesaler.signup_success')
      redirect_to spree.wholesalers_path
    else
      flash[:error] = I18n.t('spree.wholesaler.signup_failed')
      render :action => "new"
    end
  end

  def edit
    @wholesaler = Spree::Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end

  def update
    @wholesaler = Spree::Wholesaler.find(params[:id])

    if @wholesaler.update_attributes(params[:wholesaler])
      flash[:notice] = I18n.t('spree.wholesaler.update_success')
    else
      flash[:error] = I18n.t('spree.wholesaler.update_failed')
    end
    respond_with(@wholesaler)
  end

  def destroy
    @wholesaler = Spree::Wholesaler.find(params[:id])
    @wholesaler.destroy
    flash[:notice] = I18n.t('spree.wholesaler.destroy_success')
    respond_with(@wholesaler)
  end
end
