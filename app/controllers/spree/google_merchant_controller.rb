module Spree
  class GoogleMerchantController < Spree::BaseController
    respond_to :rss

    def index
      @variants = Spree::Variant.active.includes(:product)
      # @variants = [Spree::Variant.find(27)]
      respond_with(@variants)
    end
  end
end
