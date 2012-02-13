class WholesalersController < Spree::BaseController
  respond_to :html, :xml
  
  def index
  end
  
  def show
    @wholesaler = Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end
  
  def new
    @wholesaler = Wholesaler.new
    @wholesaler.build_user
    @wholesaler.bill_address = Address.default
    @wholesaler.ship_address = Address.default
    respond_with(@wholesaler)
  end
                
  def create
    @wholesaler = Wholesaler.new(params[:wholesaler])
    if @wholesaler.save
      flash[:notice] = I18n.t('wholesaler.signup_success')
      redirect_to wholesalers_path
    else
      flash[:error] = I18n.t('wholesaler.signup_failed')
      render :action => "new"
    end        
  end
  
  def edit
    @wholesaler = Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end
  
  def update
    @wholesaler = Wholesaler.find(params[:id])

    if @wholesaler.update_attributes(params[:wholesaler])
      flash[:notice] = I18n.t('wholesaler.update_success')
    else
      flash[:error] = I18n.t('wholesaler.update_failed')
    end
    respond_with(@wholesaler)
  end
  
  def destroy
    @wholesaler = Wholesaler.find(params[:id])
    @wholesaler.destroy
    flash[:notice] = I18n.t('wholesaler.destroy_success')
    respond_with(@wholesaler)
  end
end