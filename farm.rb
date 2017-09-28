class Farm
  @@farm = []
  @@hectares = 100
  @@corn = 0
  @@wheat = 0

  def initialize
    while true
      puts <<~o
      -----------------------------------
      Options:
      field -> adds a new field
      harvest -> harvests crops and adds to total harvested
      status -> displays some information about the farm
      relax -> provides lovely descriptions of your fields
      exit -> exits the program
      -----------------------------------
      o
      input = gets.chomp
      until input == "field" || input == "harvest" || input == "status" || input == "relax" || input == "exit"
        puts "That's not a valid option."
        puts "Please re-enter your option:"
        input = gets.chomp
      end
      options(input)
    end
  end

  def options(input)
    case input
      when "field" then field
      when "harvest" then harvest
      when "status" then status
      when "relax" then relax
      when "exit" then abort("Exiting...")
    end
    return true
  end

  def field
    field = Field.new
    @@farm << field
    return field
  end

  def harvest
    puts "\n"
    @@farm.each do |field|
      if field.type == "corn"
        @@corn += field.size*20
        @@hectares += field.size
        puts "You have harvested #{field.size*20} bundles of corn!"
      end

      if field.type == "wheat"
        @@wheat += field.size*30
        @@hectares += field.size
        puts "You have harvested #{field.size*30} bundles of wheat!"
      end
    end
  end

  def status
    @cornfield = @@farm.select {|field| field.type == "corn"}
    @wheatfield = @@farm.select {|field| field.type == "wheat"}
    puts <<~o

    You currently have:
    - #{@@hectares} hectares of free space
    - #{@@corn} bundles of corn
    - #{@@wheat} bundles of wheat
    - #{@cornfield.count} corn field(s)
    - #{@wheatfield.count} wheat field(s)
    - #{@@farm.count} field(s)
    o
  end

  def relax
    puts <<~o
    hi
    o
  end

end

class Field < Farm

  def initialize
    puts "\nWould you like a corn or wheat farm?"
    @type = gets.chomp
    until @type == "corn" || @type == "wheat"
      puts "We can't have #{@type} fields on this farm."
      puts "\nWould you like a corn or wheat farm?"
      @type = gets.chomp
    end

    puts "\nWhat should the area of this field be in hectares?"
    puts "You have #{@@hectares} hectares of free space in your farm."
    @size = gets.chomp.to_i
    until @size <= @@hectares
      puts "That exceeds your current space of #{@@hectares} hectares."
      puts "\nWhat should the area of this field be in hectares?"
      @size = gets.chomp.to_i
    end
    @@hectares -= @size
  end

  def size
    return @size
  end

  def type
    return @type
  end

end

Farm.new
