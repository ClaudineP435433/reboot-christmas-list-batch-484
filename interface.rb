# TODO: you can build your christmas list program here!
require_relative 'methods.rb'

GIFTS = [
  {name:"Scrabble", price: 23, bought: false},
  {name: "iphone", price: 800, bought: true}
]


puts "-"*30
puts "Welcome to your Christmas List"
puts "-"*30

loop do
  puts "What do you want to do ? Select the number"
  puts "1 - List of Gifts"
  puts "2 - Add a gift"
  puts "3 - Delete a gift"
  puts "4 - Mark as bought a gift"
  puts "5 - Import gift from ETSY"
  puts "0 - Exit List"

  action = gets.chomp

  case action
  when '1' then display_list(GIFTS)
  when '2' then add_gift(GIFTS)
  when '3' then delete_gift(GIFTS)
  when '4' then mark_as_bought(GIFTS)
  when '5' then import(GIFTS)
  when '0' then break
  else
    puts "RTFM"
  end
end
