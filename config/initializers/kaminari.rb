# to handle issue with rails admin interface

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
