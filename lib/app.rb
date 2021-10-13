require 'poke-api-v2'

def api_get_pokemon(id) # returns a POKEMON OBJECT via its id number
  return PokeApi.get(pokemon: id)
end

def create_hand(nb_cards) # returns a random HAND
  hand = Array.new
  nb_cards.times do hand.push(api_get_pokemon( rand(1..99) )) end
  return hand
end

def get_pokemon_stats(pokemon) # returns a HASH of the stats of a pokemon
  { 
    "pokemon_name": pokemon.name,
    "#{pokemon.stats[1].stat.name}" => pokemon.stats[1].base_stat,
    "#{pokemon.stats[2].stat.name}" => pokemon.stats[2].base_stat
  }
end

def fighter_hand (nb_cards) # 
  hand = create_hand(nb_cards)
  hand.map {|i| get_pokemon_stats(i)}
end

def compare_stats(player_poke, cpt_poke, match_results)
  player_health = (player_poke["defense"] - cpt_poke["attack"])
  cpt_health = (cpt_poke["defense"] - player_poke["attack"])
  # puts player_health
  # puts cpt_health
  puts puts
  if player_health > cpt_health
    puts "Tu lui as fait mordre la poussière ! Bon travail :-)"
    match_results[0] += 1
  elsif player_health < cpt_health
    puts "Tu t'es fait rosser comme un noob, retourne bosser !"
    match_results[1] += 1
  else 
    puts "Vos parents vous forcent à faire la paix et à vous serrer la main, tu te promets de le battre la prochaine fois dans l'esprit shonen."
    match_results[2] += 1
  end
  sleep 1.5
  system('clear')
  return match_results
end

def display_poke(poke)
  puts "#{poke[:pokemon_name].capitalize} : FORCE(#{poke["attack"]}) | DÉFENSE(#{poke["defense"]})"
end

def wins_report (match_results)
  system('clear')

  if match_results[0] == 3
    puts "          Tes pokémons l'ont emporté #{match_results[0]} fois. Tu es déjà le meilleur dresseur ;)"
  else
    puts "          Tes pokémons l'ont emporté #{match_results[0]} fois. Un jour tu seras (peut-être...) le meilleur dresseur :/"
  end
  puts puts
  if match_results[1] == 3
    puts "          Ceux de l'ordinateur t'ont mis #{match_results[1]} bonnes corrections. Tes pokémons seraient mieux chez la Team Rocket"
  else
    puts "          Ceux de l'ordinateur t'ont mis #{match_results[1]} bonnes corrections."
  end
  puts puts 
  if match_results[2] >= 2
    puts "          Vous avez fait #{match_results[2]} égalité. Vous êtes des BFF en devenir :)"
  else
    puts "          Et vous avez fait #{match_results[2]} égalité."
  end
end

def game_start()
  hand_player = fighter_hand(3)
  computer_player = fighter_hand(3)
  match_results = [0, 0, 0]

  while hand_player.length > 0
    puts puts
    puts "Voici ton équipe"
    hand_player.each {|i| display_poke(i)}
    position_computer_poke = rand(0..computer_player.length - 1)
    cpt_curr_fight = computer_player[position_computer_poke]
    puts puts
    puts "Tu vas affronter : "
    puts display_poke(cpt_curr_fight)
    puts puts
    puts "Choisis un poke, mec, en entrant sa position dans ton terminal de geek :"
    hand_player.each_with_index do |x, i|
      puts "Fighter: type #{i + 1} for #{x[:pokemon_name].capitalize}"
    end
    position = gets.chomp.to_i
    pl_curr_fight = hand_player[position - 1]

    match_results = compare_stats(pl_curr_fight, cpt_curr_fight, match_results)
    hand_player.delete_at(position - 1)
    computer_player.delete_at(position_computer_poke)
  end
  wins_report(match_results)
end

def process
  puts puts
  puts "Hahaha je suis Sacha du bourg Palette, je te défie !!! Pikachu attaque éclair !!!" 
  puts puts
  sleep 1.5
  game_start()
end

process