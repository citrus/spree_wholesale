module SpreeWholesale
  module WholesalerController


    def self.included(mod)
      mod.instance_eval do
        resource_controller
        prepend_before_filter :use_billing?, :only => [:create, :update]
        before_filter :setup_defaults, :only => [:new,:create,:edit,:update]
        
        index.before :new_wholesale_user
        
        helper_method :wholesale_role
        
      end
      mod.send(:include, ClassMethods)
    end
    
    module ClassMethods
      
      #=================================================
      # Overwrite point
      
      def after_wholesaler_create
        flash[:notice] = "Thank you for your interest in becoming a wholesaler! We'll be in touch shortly."
        redirect_to wholesalers_path
      end
      
      def after_wholesaler_failed_create
        flash[:error] = "Wholesale account could not be created!"
        render :action => :new
      end
  
      #=================================================
      
      def wholesale_role
        @wholesale_role ||= Role.find_or_create_by_name("wholesaler")
      end
      
      def new_wholesale_user
        @user = User.new
      end
      
      def attach_wholesaler_parts
        @wholesaler.user         = @user
        @wholesaler.bill_address = @bill_address
        @wholesaler.ship_address = @ship_address
      end
      
      def new
        @wholesaler ||= Wholesaler.new(params[:wholesaler])
      end
      
      def create
        if attach_wholesaler_parts && @wholesaler.save
          after_wholesaler_create
        else
          after_wholesaler_failed_create
        end
      end
      
      def update
        @bill_address.update_attributes(params[:bill_address])
        if use_billing?
          @wholesaler.ship_address.destroy unless @wholesaler.ship_address.nil? || @bill_address != @wholesaler.ship_address
          @ship_address = @bill_address
        else
          @ship_address = @wholesaler.build_ship_address if @ship_address.nil? || @bill_address == @wholesaler.ship_address
          @ship_address.update_attributes(params[:ship_address])
        end
        attach_wholesaler_parts
        @wholesaler.touch && @wholesaler.save
        super
      end
            
      def use_billing?
        @use_billing ||= params[:wholesaler].delete(:use_billing).to_i == 1
      end
      
      def setup_defaults
        params[:wholesaler] ||= {}
        if request.get? && params[:dev]
          params[:wholesaler] = {"company"=>"Test Company", "buyer_contact"=>"Mr Contacter", "manager_contact"=>"Mr Manager", "phone"=>"555-555-5555", "fax"=>"555-555-5555 ext 1", "resale_number"=>"13414214", "taxid"=>"555-55-5555", "web_address"=>"testcompany.com", "terms"=>"Credit Card", "notes"=>""}
          params[:user] = {"email"=>"wholesale-#{rand(100)}@example.com", :password => "password" , :password_confirmation => "password" }
          params[:bill_address] = {"firstname"=>"Mister","lastname"=>"Accountant","address1"=>"123 Anystreet", "address2"=>"", "city"=>"Anytown", "state_id"=>"276110813", "zipcode"=>"98765", "country_id"=>"214", "phone"=>"555-555-5555"}
        end
        @roles = Role.all
        case params[:action]
          when 'new', 'create'
            @wholesaler = Wholesaler.new(params[:wholesaler])    
            @user = User.new(params[:user])
            @bill_address = Address.new(params[:bill_address] || { :country_id => default_country.id })
            if use_billing?
              @ship_address = @bill_address
            else
              @ship_address = Address.new(params[:ship_address] || { :country_id => default_country.id })
            end                    
          when 'edit', 'update', 'destroy'
            @wholesaler   = Wholesaler.find(params[:id])
            @user         = @wholesaler.user
            @bill_address = @wholesaler.bill_address
            @ship_address = @wholesaler.ship_address                        
        end                
      end    
    end
  end
end
