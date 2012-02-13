class Admin::WholesalersController < Admin::ResourceController
  respond_to :html, :xml  
  before_filter :approval_setup, :only => [ :approve, :reject ]
  
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
      flash[:notice] = I18n.t('admin.wholesaler.success')
      redirect_to admin_wholesalers_path
    else
      flash[:error] = I18n.t('admin.wholesaler.failed')
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
      flash[:notice] = I18n.t('admin.wholesaler.update_success')
    else
      flash[:error] = I18n.t('admin.wholesaler.update_failed')
    end
    respond_with(@wholesaler)
  end
  
  def destroy
    @wholesaler = Wholesaler.find(params[:id])
    @wholesaler.destroy
    flash[:notice] = I18n.t('admin.wholesaler.destroy_success')
    respond_with(@wholesaler)
  end
    
  def approve
    return redirect_to request.referer, :flash => { :error => "Wholesaler is already active." } if @wholesaler.active?
    @wholesaler.activate!
    redirect_to request.referer, :flash => { :notice => "Wholesaler was successfully approved." }
  end
  
  def reject
    return redirect_to request.referer, :flash => { :error => "Wholesaler is already rejected." } unless @wholesaler.active?
    @wholesaler.deactivate!
    redirect_to request.referer, :flash => { :notice => "Wholesaler was successfully rejected." }
  end
      
  private
  
  def approval_setup
    @wholesaler = Wholesaler.find(params[:id])
    @role = Role.find_or_create_by_name("wholesaler")
  end
  
  def collection
    return @collection if @collection.present?
    
    params[:search] ||= {}
    params[:search][:meta_sort] ||= "company.asc"
    @search = Wholesaler.metasearch(params[:search])
    @collection = @search.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end 
end
