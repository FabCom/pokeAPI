require 'poke-api-v2'

def random_6_number
  array = Array.new
  6.times do
    array.push(rand(1..100))
  end
  return array
end

def get_cards array
  hand = Array.new
  array.length.times do |i|
    hand.push(PokeApi.get(pokemon: array[i]))
  end
  return hand
end

def display_pokemon (object_pokemon)
  puts object_pokemon.name
end

def get_pokemon_stats (object_pokemon)
  object_pokemon.stats.each do |i|
    print i.stat.name + " : " + i.base_stat.to_s + "|" 
  end
  puts
end

def display_hands (hand)
  hand.each do |i|
  display_pokemon(i)
  get_pokemon_stats(i)
  end
end

def delete_pokemon (hand, number_pokemon)
  hand.delete_at(number_pokemon - 1)
end

def delete_3_pokemon(hand)
  puts "Choissisez parmis les 6 pokemon, 3 pokemon a retirer"
  
  while hand.length != 3
    input = gets.chomp.to_i
    while (input > hand.length && input < 1)
      puts "Choisissez parmis 1 et #{hand.length}}"
      input = gets.chomp.to_i
    end
    delete_pokemon(hand, input)
  end
end

# puts "hand player"
 hand_player = get_cards(random_6_number)
# display_hands(hand_player)
# # puts hand_player
# puts "hand computer"
# hand_computer = get_cards(random_6_number)
# display_hands (hand_computer)

puts "choice 3 from 6 pokemon"

delete_3_pokemon(hand_player)
display_hands (hand_player)

# pikachu = PokeApi.get(pokemon: 121)



# p pikachu.stats[0].stat.name

# puts "stats"
# pikachu.stats.each do |i|
#   print i.stat.name + " : " + i.base_stat.to_s + "|"
# end

# puts puts

# puts  "Abilities"
# pikachu.abilities.each do |i|
#   print i.ability.name  + "|"
# end
# puts
# p pikachu.methods
