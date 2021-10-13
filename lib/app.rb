require 'poke-api-v2'

def create_hand(nb_pokemons)
  hand = Array.new
  nb_pokemons.times do hand.push(get_random_pokemon()) end
  return hand
end

def get_random_pokemon()
  return PokeApi.get(pokemon: rand(1..100))
end

def get_stats(pokemon)
  pokemon.stats.each do |i| print i.stat.name + ":" + i.base_stat.to_s + " | " end
  puts
end

def display_hand(hand)
  hand.each do |i|
    print i.name+": "
    get_stats(i)
  end
end

puts "Player's HAND"
player_hand = create_hand(3)
display_hand(player_hand)
puts
puts "Computer's HAND"
# Creates and displays the hand of the computer
computer_hand = create_hand(3)
display_hand(computer_hand)



