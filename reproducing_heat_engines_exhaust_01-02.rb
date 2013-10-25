###############################################################################
#                                                                             #
# REPRODUCING HEAT ENGINES SIUMLATOR - EXHAUSTIBLE RESERVOIRS version 01.02   #
#_____________________________________________________________________________#
#                                                                             #
# Copyright 2011, 2013 by Mark Ciotola; available for use under GNU license   #
# Created on 25 July 2011. Last revised on 25 October 2013                    #
#_____________________________________________________________________________#
#                                                                             #
# Developed with Ruby 1.8.7; updated to Ruby 1.9.2                            #
# Takes the following parameters: temperature of reservoirs                   #
#                                                                             #
###############################################################################

# Improvements: create objects for engine and reservoirs 

# Include
  include Math

# Create Reservoir class
  # Parameters include hot and cold temp, size of reservoirs, heat capacity of substance

  class Reservoir
	attr_accessor :rsvrtemp, :rsvrvolume, :rsvrsubstcap, :totalheat
		
	def initialize(attributes = {})
      # Initialize parameters:
	    # Reservoir Temperatures, Volumes, Heat Capacities
        @rsvrtemp = 400
        @rsvrvolume = 1000
        @rsvrsubstcap = 1.0
		@totalheat = 25.0
    end		
		
    def rsvrtemp
      return @rsvrtemp
    end

    def rsvrvolume
      return @rsvrvolume
    end

    def rsvrsubstcap
      return @rsvrsubstcap
    end

  end
  
  
# Create Engine class
  
  class Engine

    attr_accessor :engqty, :efficiency, :consumption, :production

    # Initialize parameters:
	def initialize(attributes = {})
      @consumption = 1.0 
      @efficiency = 1.0
      @engqty = 1
	  @period  = 1
	  @periods  = 20
    end

	def engqty
      return @engqty
    end
	
	def efficiency
      return @efficiency
    end
	
	def consumption
      return @consumption
    end
	
	def production
      return @production
    end

  end


# Create and Initialize Engine instance

  engine = Engine.new
  
	consumption = 1.0 
	efficiency = 1.0
	engqty = 1
	period  = 1
	periods  = 20


# Create and Initialize Hot Reservoir instance

  hotreservoir = Reservoir.new
  	
	hotreservoir.rsvrtemp = 900.0
	hotreservoir.rsvrvolume = 1.0
	hotreservoir.rsvrsubstcap = 1.0
	hotreservoir.totalheat = hotreservoir.rsvrtemp * hotreservoir.rsvrsubstcap * hotreservoir.rsvrsubstcap

  
# Create and Initialize Cold Reservoir instance

  coldreservoir = Reservoir.new
  
	coldreservoir.rsvrtemp = 300.0
	coldreservoir.rsvrvolume = 1.0
	coldreservoir.rsvrsubstcap = 1.0
	coldreservoir.totalheat = coldreservoir.rsvrtemp * coldreservoir.rsvrsubstcap * coldreservoir.rsvrsubstcap


# Simulation Banner

puts "\n\n"
puts "#########################################################################"
puts "#                                                                       #"
puts "# SIMPLE BUBBLE BY ENGINES SIUMLATOR version 1.01                       #"
puts "#_______________________________________________________________________#"
puts "#                                                                       #"
puts "# Copyright 2011 by Mark Ciotola; available for use under GNU license   #"
puts "#                                                                       #"
puts "#########################################################################"
puts "\n\n"
puts "Type Control-c to stop program if needed."
puts "\n\n"

# Initialize Simulation Parameters (please ajust parameters here rather than above)

	periods = 20.0
	hotrsvrtempin = 900.00
	coldrsvrtempin = 100.0

# User Inputs Simulation Parameters

  puts "\n\n"
  puts "Enter Hot Reservoir Temperature (positive number required): \n\n"
  hotrsvrtempin = gets.chomp
  
  	if hotrsvrtempin.to_f > 0
		hotreservoir.rsvrtemp = hotrsvrtempin.to_f
	else
		hotreservoir.rsvrtemp = hotreservoir.rsvrtemp
	end

	hotreservoir.totalheat = hotreservoir.rsvrvolume * hotreservoir.rsvrsubstcap * hotreservoir.rsvrtemp
		
		
  puts "\n\n"
  puts "Enter Cold Reservoir Temperature (must be higher than Hot Reservoir Temperature): \n\n"
  coldrsvrtempin = gets.chomp
  
  	if coldrsvrtempin.to_f < hotreservoir.rsvrtemp
		coldreservoir.rsvrtemp = coldrsvrtempin.to_f
	else
		coldreservoir.rsvrtemp = coldreservoir.rsvrtemp
	end

	coldreservoir.totalheat = coldreservoir.rsvrvolume * coldreservoir.rsvrsubstcap * coldreservoir.rsvrtemp
	

# Display Initial Parameter Values

  puts "\n\n"
  puts "PARAMETERS AND INITIAL VALUES: \n\n"
  puts sprintf "Periods: \t %3d" , periods
  puts sprintf "Hot Temperature: \t %3.3f" , hotreservoir.rsvrtemp
  puts sprintf "Cold Temperture: \t %3.3f " , coldreservoir.rsvrtemp
  puts sprintf "Hot Rsvr Volume: \t %3.3f" , hotreservoir.rsvrvolume
  puts sprintf "Cold Rsvr Volume: \t %3.3f" , coldreservoir.rsvrvolume
  
  puts sprintf "Hot Rsvr Total Heat: \t %3.3f" , hotreservoir.totalheat

       
# Display Simulation Banner
 
  puts "\n\n"  
  puts "RESULTS: \n\n"

  puts "PERIOD\t ENGS\tCONSMP\tEFFIC\tPRODTN\tCumlCons"
  puts "------\t ----\t------\t-----\t------\t--------\n"


# Calculate and Display Simulation Results (this is a loop)

	period = 1
	engqty = 1
	totcumconsp = 0.0
	totposbconsp = 500.0
	consumption = 1.0
	consumpfactor = 5.0
	efficiency = 1.0
	production = 1.0
  
	if periodsin = ""
		periods = periods
	else
		periods = periodsin
	end
  
	while coldreservoir.rsvrtemp < hotreservoir.rsvrtemp do

		if (totcumconsp < totposbconsp)
			consumption = engqty * consumpfactor
		else
			consumption = 0.0
		end
	
	  efficiency =  1.0 - (coldreservoir.rsvrtemp/hotreservoir.rsvrtemp.to_f)
      production = consumption * efficiency

		per = period
		qty = engqty
		raw = [consumption, 0.0].max
		eff = [efficiency, 0.0].max
		net = [production, 0.0].max
		cum = totcumconsp  # (totcumconsp/totposbconsp.to_f)
		tohot = hotreservoir.rsvrtemp * 1.0
		tocold = coldreservoir.rsvrtemp * 1.0

		mystring = ("%d\t%5.2f\t%6.3f\t%1.3f\t%6.3f \t %5.3f   \t%5.3f\t%5.3f ")
		puts sprintf mystring, per.to_s, qty.to_s,raw.to_s, eff.to_s, net.to_s, cum.to_s, tohot.to_s, tocold.to_s

		period = period + 1
		engqty = engqty + production / 10.0
		totcumconsp = totcumconsp + consumption
	
		hotreservoir.rsvrtemp = (hotreservoir.totalheat - consumption)/(hotreservoir.rsvrvolume * hotreservoir.rsvrsubstcap)
		hotreservoir.totalheat = hotreservoir.totalheat - consumption
	 
		coldreservoir.rsvrtemp = (coldreservoir.totalheat - consumption)/(coldreservoir.rsvrvolume * coldreservoir.rsvrsubstcap)
		coldreservoir.totalheat = coldreservoir.totalheat + consumption

	end

puts "\nDone. \n\n"


# End Matter, Including Key to Output

	puts "KEY: \n\n"
	puts "  ENGS: \t\tQuantity of Engines\n"
	puts "  CONSMP: \t\tConsumption\n"
	puts "  EFFIC: \t\tEfficiency\n"
	puts "  PRODTN: \t\tProduction\n"

	puts "  \n\n"


########################### UNUSED CODE THAT MIGHT BE NEEDED LATER ###############################

#    if efficiency_decay === "e"
#      engine.efficiency = exp( - 6 * ((bubble.period - 1)/periods.to_f ) )
#    elsif efficiency_decay === "n"
#      engine.efficiency =  1.0
#    else efficiency_decay === "l"
#      engine.efficiency =  1.0 - (bubble.period/periods.to_f)
#    end

