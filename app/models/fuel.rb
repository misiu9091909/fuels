class Fuel < ActiveRecord::Base
  
  def self.last_run_date
    Fuel.maximum(:created_at)
  end
  
  def self.load_data_from_remote

    response = HTTParty.get('http://lukoil.wincor-nixdorf.cz/LukoilStationService/rest/getFuelPrices/POL/')

    date = DateTime.strptime(response.parsed_response["date"], '%Y-%m-%dT%H:%M:%S')
    
    unless date == Fuel.last_run_date
      fuel_prices = response.parsed_response["fuel-prices"]
      fuel_prices.each do |x|
      	@fuelType = case x['fuelType']
      	  when "P110" then "Pb98"
      	  when "P120" then "Pb95"
      	  when "P140" then "ON"
      	  when "P150" then "LPG"
      	end
        Fuel.new(:created_at => date, :price => x['price'], :site_id => x['siteId'], :fuel_type => @fuelType).save  
	  end
	end
  end
end