Admin::UsersController.class_eval do
  
  before_filter :wholeale_setup, :only => [:approve_wholesale, :reject_wholesale]
  
  def approve_wholesale
    return redirect_to request.referer, :flash => { :error => "User could not be approved." } if @user.roles.include?(@role)
    @user.roles << @role
    @user.save
    redirect_to request.referer, :flash => { :notice => "User was successfully approved." }
  end
  
  def reject_wholesale  
    return redirect_to request.referer, :flash => { :error => "User could not be rejected wholesale rights." } unless @user.roles.include?(@role)
    @user.roles.delete(@role)
    @user.save
    redirect_to request.referer, :flash => { :notice => "User was successfully rejected." }
  end
  
  def wholeale_setup
    @user = User.find(params[:id])  
    @role = Role.find_or_create_by_name("wholesaler")
  end
  
end