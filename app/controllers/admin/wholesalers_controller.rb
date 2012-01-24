class Admin::WholesalersController < Admin::ResourceController
  include SpreeWholesale::WholesalerController
  
  before_filter :approval_setup, :only => [ :approve, :reject ]
  
  def after_wholesaler_create
    flash[:notice] = t('admin.wholesalers.success')
    redirect_to admin_wholesalers_path
  end
  
  def after_wholesaler_failed_create
    flash[:error] = t('admin.wholesalers.failed')
    render :action => :new
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
  
  def approval_setup
    @wholesaler = Wholesaler.find(params[:id])
    @role = Role.find_by_name("wholesaler")
  end
    
  private
  
    def collection
      return @collection if @collection.present?
      
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "company.asc"
      @search = Wholesaler.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:admin_products_per_page])
    end
 
end
