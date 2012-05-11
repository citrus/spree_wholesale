class Spree::Admin::WholesalersController < Spree::Admin::ResourceController
  respond_to :html, :xml
  before_filter :approval_setup, :only => [ :approve, :reject ]

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
      flash[:notice] = I18n.t('spree.admin.wholesaler.success')
      redirect_to spree.admin_wholesalers_path
    else
      flash[:error] = I18n.t('spree.admin.wholesaler.failed')
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
      flash[:notice] = I18n.t('spree.admin.wholesaler.update_success')
    else
      flash[:error] = I18n.t('spree.admin.wholesaler.update_failed')
    end
    respond_with(@wholesaler)
  end

  def destroy
    @wholesaler = Spree::Wholesaler.find(params[:id])
    @wholesaler.destroy
    flash[:notice] = I18n.t('spree.admin.wholesaler.destroy_success')
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
    @wholesaler = Spree::Wholesaler.find(params[:id])
    @role = Role.find_or_create_by_name("wholesaler")
  end

  def collection
    return @collection if @collection.present?

    params[:search] ||= {}
    params[:search][:meta_sort] ||= "company.asc"
    @search = Spree::Wholesaler.metasearch(params[:search])
    @collection = @search.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end
end
