
###############################################################################
#                                                                             #
# CARNOT ENGINES - WITH EXHAUSTIBLE RESERVOIRS version 01.03                  #
#_____________________________________________________________________________#
#                                                                             #
# Copyright 2011, 2013 by Mark Ciotola; available for use under GNU license   #
# Created on 14 June 2014. Last revised on 17 June 2014                       #
#_____________________________________________________________________________#
#                                                                             #
# Developed with Ruby 1.8.7; updated to Ruby 1.9.2 & 2.?                      #
# Takes the following parameters: temperature of reservoirs?                  #
#                                                                             #
###############################################################################

# OMIT HOLISTICS ENTROPY CALC FOR EACH RESERVOIR, JUST DO DIFFERENCES;
# THIS IS ONLY APPROXIMATELY LINEAR.


# Choose Parameters

  hotenergyinit =  100000.0 #J

  coldenergyinit =  30000.0 #J

  coldspecificheat = 1.0

  hotspecificheat = 2.0

  hotvolume = 1000.0 #m^2

  coldvolume = 1000.0 #m^2

  engineconsumption = 1000.0 #J/s


  hotenergy = hotenergyinit #J

  coldenergy = coldenergyinit #J


# Initialize Variables

  time = 0

  culprod = 0.0

  hottemp = hotenergy/(hotvolume * hotspecificheat) #K

  coldtemp = coldenergy/(coldvolume * coldspecificheat) #K

puts "Initial Temps\n"
puts hottemp.to_s, coldtemp.to_s
puts "\n\n"

# Display Simulation Banner

puts "\n\n"
puts "RESULTS: \n\n"

puts "PERIOD\tT hot\tT cold \tCONSMP\tE hot \tE cold\tEFFIC\tPRODTN\t CumlProd\tHot S c\tCold S c"
puts "------\t------\t------\t------\t------\t------\t-----\t------\t --------\t-------\t--------\n"

# Calculate and Display Results


    
while coldtemp < hottemp
    
    efficiency = 1 - (coldtemp/hottemp)
  
    engineproduction = engineconsumption * efficiency
  
    hotenergy = hotenergy - engineconsumption
  
    coldenergy = coldenergy + engineconsumption
  
    culprod = culprod + engineproduction
  
  hotentropychange = - engineconsumption / hottemp
  
  coldentropychange = (engineconsumption - engineproduction) / coldtemp
 

  

  
  # Add reproduction
  

# Display Variable Shorts

t = time
ht = hottemp
ct = coldtemp
he = hotenergy
ce = coldenergy
ec = engineconsumption
eff = efficiency
ep = engineproduction
cp = culprod
hs = hotentropychange
cs = coldentropychange


mystring = ("%d\t%5.2f\t%6.3f\t%6.0f\t%5.0f\t%5.0f\t%5.3f\t%6.2f\t%9.2f\t%6.2f\t%6.2f  ")
puts sprintf mystring, t.to_s, ht.to_s, ct.to_s, ec.to_s, he.to_s, ce.to_s, eff.to_s, ep.to_s, cp.to_s, hs.to_s, cs.to_s

hottemp = hotenergy/(hotvolume * hotspecificheat) #K

coldtemp = coldenergy/(coldvolume * coldspecificheat) #K

    time = time + 1
    
   end




puts "\n\n"



puts "\n\n"

puts "================================== Units Key ==================================\n\n"
puts "  Abbreviation: \t\t Unit:"
puts "\n"
puts "       J \t\t\t Joules, a unit of energy"
puts "       K \t\t\t Kelvin, a unit of temperature"
puts "       m \t\t\t meters, a unit of length"
puts "       s \t\t\t seconds, a unit of time"
puts "\n\n"


puts "================================== References =================================\n\n"
puts "Daniel V. Schroeder, 2000, \"An Introduction to Thermal Physics.\""
puts "\n\n"

