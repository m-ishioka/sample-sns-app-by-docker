Dir[Rails.root.join('lib/patches/**/*.rb')].each do |file|
  require file
end
