# Classe para representar os personagens
class Character
  attr_accessor :name, :health, :attack, :defense, :level, :experience, :inventory, :quests

  def initialize(name, health, attack, defense)
    @name = name
    @health = health
    @attack = attack
    @defense = defense
    @level = 1
    @experience = 0
    @inventory = []
    @quests = []
  end

  def take_damage(amount)
    damage = [amount - @defense, 0].max
    @health -= damage
    puts "#{@name} took #{damage} damage. Health: #{@health}"
  end

  def attack_enemy(enemy)
    damage = [@attack - enemy.defense, 0].max
    puts "#{@name} attacks #{enemy.name} for #{damage} damage!"
    enemy.take_damage(damage)
  end

  def heal(amount)
    @health += amount
    puts "#{@name} heals for #{amount}. Health: #{@health}"
  end

  def level_up
    @level += 1
    @attack += 5
    @defense += 2
    @health += 20
    puts "#{@name} leveled up! New level: #{@level}, Attack: #{@attack}, Defense: #{@defense}, Health: #{@health}"
  end

  def gain_experience(exp)
    @experience += exp
    puts "#{@name} gained #{exp} experience!"

    if @experience >= 100
      level_up
      @experience = 0
    end
  end

  def is_alive?
    @health > 0
  end

  def add_item(item)
    @inventory.push(item)
    puts "#{item} has been added to your inventory."
  end

  def show_inventory
    puts "Inventory: #{@inventory.join(', ')}"
  end
end

# Classe para inimigos
class Enemy < Character
  def initialize(name, health, attack, defense)
    super(name, health, attack, defense)
  end
end

# Classe para representar um NPC (Personagem Não Jogável)
class NPC
  attr_accessor :name, :quests

  def initialize(name)
    @name = name
    @quests = []
  end

  def offer_quest(quest)
    @quests.push(quest)
    puts "#{@name} has offered a new quest: #{quest.name}"
  end
end

# Classe para representar uma missão
class Quest
  attr_accessor :name, :description, :completed, :reward

  def initialize(name, description, reward)
    @name = name
    @description = description
    @completed = false
    @reward = reward
  end

  def complete_quest
    @completed = true
    puts "Quest Completed: #{@name}! You have received #{@reward}."
  end
end

# Classe para gerenciar batalhas
class Battle
  def initialize(player, enemy)
    @player = player
    @enemy = enemy
  end

  def start
    puts "A battle has started between #{@player.name} and #{@enemy.name}!"

    while @player.is_alive? && @enemy.is_alive?
      puts "Choose an action: 1. Attack 2. Heal 3. Inventory"
      action = gets.chomp.to_i

      case action
      when 1
        @player.attack_enemy(@enemy)
        @enemy.attack_enemy(@player) if @enemy.is_alive?
      when 2
        @player.heal(20)
        @enemy.attack_enemy(@player) if @enemy.is_alive?
      when 3
        @player.show_inventory
        @enemy.attack_enemy(@player) if @enemy.is_alive?
      else
        puts "Invalid action."
      end

      if !@player.is_alive?
        puts "#{@player.name} has been defeated!"
        break
      elsif !@enemy.is_alive?
        puts "#{@enemy.name} has been defeated!"
        @player.gain_experience(50)
        break
      end
    end
  end
end

# Função para criar uma missão e atribuir ao NPC
def create_quests
  quest1 = Quest.new("Find the Lost Sword", "Retrieve the lost sword from the cave.", "500 Gold")
  quest2 = Quest.new("Defeat the Bandits", "Defeat the bandits terrorizing the town.", "1000 Gold")

  npc1 = NPC.new("Guard")
  npc1.offer_quest(quest1)

  npc2 = NPC.new("Village Elder")
  npc2.offer_quest(quest2)

  return [npc1, npc2]
end

# Função para criar inimigos
def create_enemy(name, health, attack, defense)
  Enemy.new(name, health, attack, defense)
end

# Função principal do jogo
def start_game
  puts "Welcome to the world of RPG!"

  # Criando o jogador
  player = Character.new("Hero", 100, 20, 10)

  # Criando NPCs e atribuindo missões
  npcs = create_quests

  # Exibindo as missões
  npcs.each do |npc|
    puts "#{npc.name} has the following quests: "
    npc.quests.each { |quest| puts "  - #{quest.name}: #{quest.description}" }
  end

  # Escolhendo um inimigo para batalha
  enemy = create_enemy("Dragon", 150, 25, 15)

  # Iniciando uma batalha
  battle = Battle.new(player, enemy)
  battle.start
end

# Executando o jogo
start_game
