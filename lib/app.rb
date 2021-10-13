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

def get_pokemon_stats (poke_object)
  poke_stats = {
    "pokemon_name": poke_object.name,
    "#{poke_object.stats[1].stat.name}" => poke_object.stats[1].base_stat,
    "#{poke_object.stats[2].stat.name}" => poke_object.stats[2].base_stat
  }
  return poke_stats
end

def fighter_hand (hand)
  current_hand = []
  hand.each do |i|
    current_hand.push(get_pokemon_stats(i))
  end
  return current_hand
end

def compare_stats(player_poke, cpt_poke)
  player_health = (cpt_poke["attack"].to_i - player_poke["defense"].to_i)
  cpt_health = (player_poke["attack"].to_i - cpt_poke["defense"].to_i)
  puts player_health 
  puts cpt_health 
  if player_health > cpt_health
    puts "tu lui as niqué sa race"
  elsif player_health < cpt_health
    puts "il te traite de salop"
  else puts "vos parents vous forcent à vous serrer la main, tu lui fais un fuck en partant"  
  end
end

def game_start(func)
  hand_player = func.slice(0, 3)
  computer_player = func.slice(3, func.size - 1)
  
  puts "Choose a character MAN"
  puts "Enter the position of the Pokemon you want"

  hand_player.each_with_index do |x, i| 
    puts "Fighter: type #{i + 1} for #{x[:pokemon_name].capitalize}"
  end
  position = gets.chomp.to_i
  pl_curr_fight = hand_player[position - 1]
  cpt_curr_fight = computer_player[rand(0..computer_player.length - 1)]
  compare_stats(pl_curr_fight, cpt_curr_fight)
  game_start(fighter_hand(get_cards(random_6_number)))
end

puts "Hahaha je suis Sacha du bourg Palette, je te défie !!! Pikachu attaque éclair !!!"
game_start(fighter_hand(get_cards(random_6_number)))


