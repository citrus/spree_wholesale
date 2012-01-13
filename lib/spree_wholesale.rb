require 'spree_core'
require 'spree_auth'
require 'spree_sample' unless Rails.env == 'production'

require 'spree_wholesale/engine'
require 'spree_wholesale/wholesaler_controller'