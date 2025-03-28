# Definindo uma classe para representar um personagem
class Character
  attr_accessor :name, :health, :attack, :defense, :experience, :level

  def initialize(name, health, attack, defense)
    @name = name
    @health = health
    @attack = attack
    @defense = defense
    @experience = 0
    @level = 1
  end

  def take_damage(amount)
    damage = amount - @defense
    damage = 0 if damage < 0
    @health -= damage
    puts "#{@name} took #{damage} damage. #{@name} now has #{@health} health."
  end

  def attack_enemy(enemy)
    damage = @attack
    puts "#{@name} attacks #{enemy.name} for #{damage} damage!"
    enemy.take_damage(damage)
  end

  def heal(amount)
    @health += amount
    puts "#{@name} heals #{amount} health. #{@name} now has #{@health} health."
  end

  def gain_experience(amount)
    @experience += amount
    puts "#{@name} gains #{amount} experience! #{@name} now has #{@experience} experience."

    if @experience >= 100
      level_up
    end
  end

  def level_up
    @level += 1
    @experience = 0
    @attack += 5
    @defense += 2
    @health += 20
    puts "#{@name} leveled up to level #{@level}! Attack, Defense, and Health increased!"
  end

  def is_alive?
    @health > 0
  end
end

# Definindo uma classe para o jogo
class Battle
  def initialize(player, enemy)
    @player = player
    @enemy = enemy
  end

  def start
    puts "A battle between #{@player.name} and #{@enemy.name} has started!"
    
    while @player.is_alive? && @enemy.is_alive?
      puts "\nChoose an action:"
      puts "1. Attack"
      puts "2. Heal"
      action = gets.chomp.to_i

      if action == 1
        @player.attack_enemy(@enemy)
        if @enemy.is_alive?
          @enemy.attack_enemy(@player)
        end
      elsif action == 2
        healing_amount = 20
        @player.heal(healing_amount)
        @enemy.attack_enemy(@player) if @enemy.is_alive?
      else
        puts "Invalid action! Choose 1 or 2."
      end

      if !@player.is_alive?
        puts "#{@player.name} has been defeated!"
        break
      elsif !@enemy.is_alive?
        puts "#{@enemy.name} has been defeated!"
        break
      end
    end

    if @player.is_alive?
      @player.gain_experience(50)
    end
  end
end

# Criando o jogador e inimigo
player = Character.new("Hero", 100, 20, 5)
enemy = Character.new("Dragon", 80, 25, 10)

# Iniciando a batalha
battle = Battle.new(player, enemy)
battle.start

# Após a batalha, mostrar os status finais
puts "\nFinal Stats:"
puts "#{player.name} - Level: #{player.level}, Health: #{player.health}, Attack: #{player.attack}, Defense: #{player.defense}, Experience: #{player.experience}"
puts "#{enemy.name} - Level: #{enemy.level}, Health: #{enemy.health}, Attack: #{enemy.attack}, Defense: #{enemy.defense}, Experience: #{enemy.experience}"
