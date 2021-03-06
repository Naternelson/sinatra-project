require './config/environment'
require 'sinatra/activerecord/rake'

task :console do
  def clear_data
    Product.all.each {|p| p.delete}
    ItemRequirement.all.each{|i| i.delete}
    Order.all.each {|o| o.delete}
    User.all.each {|u| u.delete}
    "Data cleared"
  end



  Pry.start
end