Admin::OrdersController.class_eval do

  def collection
    params[:search] ||= {}

    if params[:search].present?
      if params[:search].delete(:completed_at_not_null) == "1"
        params[:search][:completed_at_not_null] = "1"
      end
    else
      params[:search][:completed_at_not_null] = "1"
    end

    if !params[:search][:completed_at_greater_than].blank?
      params[:search][:completed_at_greater_than] = Time.zone.parse(params[:search][:completed_at_greater_than]).beginning_of_day rescue ""
    end

    if !params[:search][:completed_at_less_than].blank?
      params[:search][:completed_at_less_than] = Time.zone.parse(params[:search][:completed_at_less_than]).end_of_day rescue ""
    end

    if params[:search][:wholesale].present?
      if params[:search].delete(:wholesale) == "1"
        params[:search][:wholesale] = 1
      end
    end

    params[:search][:order] ||= "descend_by_completed_at"
    
    @search = Order.searchlogic(params[:search])

    # QUERY - get per_page from form ever???  maybe push into model
    # @search.per_page ||= Spree::Config[:orders_per_page]

    @collection = @search.do_search.paginate(:include  => [:user, :shipments, :payments],
                                   :per_page => Spree::Config[:orders_per_page],
                                   :page     => params[:page])
  end
  
end