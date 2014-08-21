xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss "version" => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
  xml.channel do
    xml.title Spree::GoogleMerchant::Config[:google_merchant_title]
    xml.description Spree::GoogleMerchant::Config[:google_merchant_description]

    production_domain = Spree::GoogleMerchant::Config[:production_domain]
    xml.link production_domain

    @products.each do |product|
      xml.item do
        xml.id product.id.to_s
        xml.title product.name
        xml.description product.description.strip_html_tags unless product.description.blank?
        xml.link production_domain + 'products/' + product.slug
        xml.tag! "g:mpn", product.sku.to_s
        xml.tag! "g:id", product.id.to_s
        xml.tag! "g:price", product.price
        xml.tag! "g:condition", "new"
        xml.tag! "g:availability", "in stock"
        xml.tag! "g:image_link", ( product.images.first.attachment.url(:product)) unless product.images.empty?
        (product.images[1..10] || []).each do |image|
          xml.tag! "g:additional_image_link",  image.attachment.url(:product)
        end
        xml.tag! "g:brand", product.property("brand") if product.property("brand").present?
        xml.tag! "g:gtin", product.property("gtin") if product.property("gtin").present?
      end
    end
  end
end
