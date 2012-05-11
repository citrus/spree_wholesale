[Spree::BaseController, Spree::Admin::BaseController].each do |controller|

  controller.class_eval do

    def default_country
      @default_country ||= Spree::Country.find Spree::Config[:default_country_id]
    end

  end

end
