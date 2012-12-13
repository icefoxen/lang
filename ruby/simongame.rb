#!/usr/bin/env ruby

class ResourceError < RuntimeError
  def initialize(resource)
    @res = resource
  end
  def to_s
    return "Aiee!  You're out of #{@res}!"
  end
end

# BUGGO:
# If we wanted a resource to have more properties than just a number,
# this could get inconvenient.
# For instance, if you wanted to be able to make 'wood', and have it
# be able to be used as a fuel, a building material, or a trade good
# without special casing it all over the place.
class Stockpile
  attr_accessor :stock
  def initialize()
    @stock = Hash.new(0)
    @stock[:food] = 0
    @stock[:gold] = 0
    @stock[:iron] = 0
  end

  def addResource(resource, amount)
    if (@stock[resource] + amount) < 0 then
      raise ResourceError.new(resource) # "Aiee!  You're out of #{resource}"
    end
    @stock[resource] += amount
  end

  def add(stockpile)
    stockpile.stock.each {|resource, amount|
      addResource(resource, amount)
    }
  end

  def to_s()
    str = "You have:\n"
    @stock.each {|resource, amount|
      str += "#{resource}: #{amount}\n"
    }
    return str
  end
end

# BUGGO: 
# Can't return more than one kind of resource right now
# Also have to specify every source every time, which would get tedious.
# Also, the replenishment is wonky.
class ResourceSource
  attr_accessor :name, :resource, :manpower, :richness, :replenish
  def initialize(name, resource, manpower, richness, replenish)
    @name = name
    @resource = resource
    @manpower = manpower
    @richness = richness
    @replenish = replenish
  end

  def exploit(mans)
    amountTaken = mans / @manpower
    @richness -= amountTaken
    s = Stockpile.new()
    s.addResource(resource, amountTaken)
    return s
  end

  def replenish()
    @richness += @replenish
  end

  def to_s()
    return "#{@name}, provides #{@resource}, manpower cost #{@manpower}, richness #{@richness}, replenish rate #{@replenish}"
  end
end

# BUGGO:
# Everybody exploits every resource
# Population doesn't die for lack of food, or even stop breeding.
# Resources are directly tied to a particular city, which may or may
# not make sense.
# Also, people and resources and such should probably be ensured to
# be integers.
$birthrate = 1.04

class City
  attr_accessor :name, :population, :resources, :stocks

  def initialize(name, pop, resources)
    @name = name
    @population = pop
    @resources = resources
    @stocks = Stockpile.new()
    @stocks.addResource(:food, 500)
  end

  def work()
    @resources.each {|source|
      source.replenish()
      res = source.exploit(@population)
      @stocks.add(res)
    }
  end

  def eat()
    @stocks.addResource(:food, -@population)
  end

  def breed()
    newpop = @population * $birthrate
    if @population == newpop then
      @population += 1
    else
      @population = newpop
    end
  end

  def replenish()
    @resources.each {|source| source.replenish()}
  end

  def run()
    work()
    eat()
    breed()
    replenish()
  end

  def to_s()
    s = "The grand city of #{@name}, home to #{@population} people!\n"
    s += "It has the following natural bounty:\n"
    @resources.each {|source|
      s += source.to_s()
      s += "\n"
    }
    s += "Its mighty stockpiles hold:\n"
    s += @stocks.to_s()
    return s
  end
end


def mainloop()
  r1 = ResourceSource.new("Placer gold", :gold, 5, 500, 1)
  r2 = ResourceSource.new("Gold mine", :gold, 20, 10000, 0)
  r3 = ResourceSource.new("Bog iron", :iron, 3, 250, 0)
  r4 = ResourceSource.new("Herds", :food, 5, 200, 20)
  r5 = ResourceSource.new("Farms", :food, 15, 500, 100)
  resources = [r1, r2, r3, r4, r5]
  city = City.new("Sibertopia", 50, resources)
  while true do
    puts city
    puts "Press enter to generate next turn!"
    gets
    city.run()
  end
end

mainloop()
