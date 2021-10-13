require 'poke-api-v2'

pikachu = PokeApi.get(pokemon: 'pikachu')

p pikachu.stats[0].stat.name

puts "stats"
pikachu.stats.each do |i|
  print i.stat.name + " : " + i.base_stat.to_s + "|"
end

puts puts

puts  "Abilities"
pikachu.abilities.each do |i|
  print i.ability.name  + "|"
end
puts
# p pikachu.methods
