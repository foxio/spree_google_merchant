xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss "version" => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
  xml.channel do
    xml.title Spree::GoogleMerchant::Config[:google_merchant_title]
    xml.description Spree::GoogleMerchant::Config[:google_merchant_description]

    production_domain = Spree::GoogleMerchant::Config[:production_domain]
    xml.link production_domain
    @variants.first(10).each do |x|
      next if (x.is_master? && x.product.variants.count > 1)
      xml.item do
        xml.id x.id.to_s
        xml.title x.name
        xml.description x.description.strip_html_tags unless x.description.blank?
        xml.link production_domain + '/products/' + x.slug
        xml.tag! "g:mpn", x.sku.to_s
        xml.tag! "g:id", x.id.to_s
        xml.tag! "g:price", x.price unless x.price <= 0.0
        xml.tag! "g:condition", "new"
        xml.tag! "g:availability", "in stock"
        xml.tag! "g:image_link", ( x.product.images.first.attachment.url(:product)) unless x.product.images.empty?
        (x.images[1..10] || []).each do |image|
          xml.tag! "g:additional_image_link",  image.attachment.url(:product)
        end
        xml.tag! "g:shipping_weight", x.weight unless x.weight <= 0
        xml.tag! "g:brand", x.product.property("brand") if x.product.property("brand").present?
        xml.tag! "g:gtin", x.product.property("gtin") if x.product.property("gtin").present?
      end
    end
  end
end
