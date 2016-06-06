class Item
  def choose
    puts "Please enter the type you want:"
    @type = gets.chomp
    puts "Thank you, now please enter how many of those you want:"
    @quantity = gets.chomp
  end
end