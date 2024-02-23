module Attacks
  class Attack
    attr_reader :name, :damage

    def initialize(name, damage)
      @name = name
      @damage = damage
    end
  end

  module FlyingAttacks
    PECK = Attack.new("Peck", 35)
    SKY_ATTACK = Attack.new("Sky Attack", 140)
    WING_ATTACK = Attack.new("Wing Attack", 60)

    def available_attacks
      [PECK, SKY_ATTACK, WING_ATTACK]
    end
  end

  module WaterAttacks
    BUBBLE = Attack.new("Bubble", 40)
    CLAMP = Attack.new("Clamp", 35)
    HYDRO_PUMP = Attack.new("Hydro Pump", 110)
    WATER_GUN = Attack.new("Water Gun", 40)

    def available_attacks
      [BUBBLE, CLAMP, HYDRO_PUMP, WATER_GUN]
    end
  end
end

class Animal
  attr_accessor :name, :gender, :health, :speed

  def initialize(name, gender, health, speed)
    @name = name
    @gender = gender
    @health = health
    @speed = speed
  end

  def attack(target, attack)
    if should_dodge?(target.speed)
      puts "#{target.name} dodged the attack!"
    else
      puts "#{name} uses #{attack.name} on #{target.name} causing #{attack.damage} damage!"
      target.take_damage(attack.damage)
    end
  end

  def should_dodge?(opponent_speed)
    dodge_chance = speed / (speed + opponent_speed.to_f)
    rand < dodge_chance
  end

  def take_damage(damage)
    @health -= damage
    @health = 0 if @health < 0
  end

  def alive?
    @health > 0
  end
end

class Bird < Animal
  include Attacks::FlyingAttacks
end

class Fish < Animal
  include Attacks::WaterAttacks
end

class Player
  attr_accessor :name, :pets, :active_pet

  def initialize(name)
    @name = name
    @pets = []
    @active_pet = nil
  end

  def add_pet(pet)
    @pets << pet
  end

  def switch_active_pet(pet_index)
    @active_pet = @pets[pet_index]
  end

  def active_pet_index
    @pets.find_index @active_pet
  end

  def alive?
    @pets.any?(&:alive?)
  end

  def has_active_pet?
    !@active_pet.nil? && @active_pet.alive?
  end
end

class Game
  def initialize(player1, player2)
    @players = [player1, player2]
    @current_player_index = 0

    @players.each { |player| player.switch_active_pet(0) }
  end

  def start
    while players_alive?
      @current_player = @players[@current_player_index]
      @opponent = @players[1 - @current_player_index]

      play_turn
      switch_turn
    end

    display_winner
  end

  private

  def play_turn
    puts "\n======= #{@current_player.name}'s Turn ======="
    display_status
    action_menu
  end

  def display_status
    @players.each do |player|
      puts "#{player.name}'s Pets:"
      player.pets.each_with_index do |pet, index|
        status = pet.alive? ? "Alive" : "Fainted"
        selected = (index == player.active_pet_index) ? "(selected)" : ""
        puts "#{index + 1}. #{pet.name} (Health: #{pet.health}, Status: #{status}) #{selected}"
      end
    end
  end

  def action_menu
    puts "\nChoose a pet to use or switch:"
    @current_player.pets.each_with_index do |pet, index|
      status = pet.alive? ? "(Alive)" : "(Fainted)"
      selected = (index == @current_player.active_pet_index) ? "(selected)" : ""
      puts "#{index + 1}. #{pet.name} #{status} #{selected}"
    end
    print "Enter the pet's number to select or switch: "
    pet_index = gets.chomp.to_i - 1

    if pet_index.between?(0, @current_player.pets.length - 1)
      switch_to_pet(pet_index)
    else
      puts "Invalid pet number! Please try again."
      action_menu
    end
  end

  def switch_to_pet(pet_index)
    current_pet = @current_player.active_pet
    selected_pet = @current_player.pets[pet_index]

    if !selected_pet.alive?
      puts "Cannot select a fainted pet!"
      action_menu
    end

    if current_pet == selected_pet
      display_attack_menu
    elsif current_pet != selected_pet
      @current_player.switch_active_pet(pet_index)
    else
      @current_player.switch_active_pet(pet_index)
      display_attack_menu
    end
  end

  def display_attack_menu
    available_attacks = @current_player.active_pet.available_attacks

    puts "\nChoose an attack:"
    available_attacks.each_with_index do |attack, index|
      puts "#{index + 1}. #{attack.name} (Damage: #{attack.damage})"
    end
    print "Enter your choice: "
    attack_choice = gets.chomp.to_i

    if attack_choice.between?(1, available_attacks.length)
      selected_attack = available_attacks[attack_choice - 1]
      @current_player.active_pet.attack(@opponent.active_pet, selected_attack)
    else
      puts "Invalid choice! Please try again."
      display_attack_menu
    end
  end

  def switch_turn
    @current_player_index = 1 - @current_player_index
  end

  def players_alive?
    @players.all?(&:alive?)
  end

  def display_winner
    winner = @players.find(&:alive?)
    puts "#{winner.name} wins!"
  end
end

player1 = Player.new("Player 1")
player2 = Player.new("Player 2")

player1.add_pet(Bird.new("Sparrow", "Female", 90, 40))
player1.add_pet(Bird.new("Pidgey", "Male", 100, 50))
player2.add_pet(Fish.new("Gyarados", "Male", 120, 70))
player2.add_pet(Fish.new("Magikarp", "Female", 80, 30))

game = Game.new(player1, player2)
game.start
