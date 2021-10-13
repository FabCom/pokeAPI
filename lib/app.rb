require 'poke-api-v2'



def api_get_pokemon(id) # returns a POKEMON OBJECT via its id number
  return PokeApi.get(pokemon: id)
end

def get_poke_stats(poke) # returns a HASH of the stats of a pokemon
  { 
    "pokemon_name": poke.name,
    "#{poke.stats[1].stat.name}" => poke.stats[1].base_stat,
    "#{poke.stats[2].stat.name}" => poke.stats[2].base_stat
  }
end


def welcome()
  puts puts
  puts "Hahaha je suis Sacha du bourg Palette, je te défie !!!" 
  sleep 0.5
  puts "Pikachu attaque éclair !!!"
  puts puts
end

def create_hand(nb_cards) # returns a random HAND of pokemons
  hand = Array.new
  nb_cards.times do hand.push(api_get_pokemon( rand(1..99) )) end
  hand.map {|i| get_poke_stats(i)}
end

def display_poke(poke)
  puts "#{poke[:pokemon_name].capitalize} : FORCE(#{poke["attack"]}) | DÉFENSE(#{poke["defense"]})"
end

def compare_stats(player_poke, cpt_poke, match_results)
  player_health = (player_poke["defense"] - cpt_poke["attack"])
  cpt_health = (cpt_poke["defense"] - player_poke["attack"])
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


def game()
  player_hand = create_hand(3)
  computer_hand = create_hand(3)
  match_results = [0, 0, 0]

  while player_hand.length > 0

    puts "Voici ton équipe"
    player_hand.each {|poke| display_poke(poke)}
    puts puts
    sleep 0.5

    computer_poke_position = rand(0..computer_hand.length - 1)
    fighting_computer_poke = computer_hand[computer_poke_position]
    puts "Tu vas affronter ..."
    puts display_poke(fighting_computer_poke)
    puts puts
    sleep 1

    puts "Choisis un poke, mec! Entre sa position dans ton terminal de geek!"
    player_hand.each_with_index do |poke, i| 
      puts "#{i + 1} : fight with #{poke[:pokemon_name].capitalize}"
    end
    player_poke_position = gets.chomp.to_i - 1
    fighting_player_poke = player_hand[player_poke_position]

    match_results = compare_stats(fighting_player_poke, fighting_computer_poke, match_results)
    player_hand.delete_at(player_poke_position)
    computer_hand.delete_at(computer_poke_position)
  end

  wins_report(match_results)
end

def process
  system('clear')
  welcome
  game
end

process