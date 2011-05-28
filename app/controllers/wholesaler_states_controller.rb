class WholesalerStatesController < Admin::BaseController

  def index
    if params[:country_id]
      @country = Country.includes(:states).find(params[:country_id]) rescue nil
      @states  = @country.states.order(:name).all if @country
    end
    render :partial => "shared/state_field", :locals => { :states => @states }
  end

end
