class ProverbGenerator
  attr_accessor :words

  def initialize(words)
    @words = words
  end

  def generate
    n = @words.length
    (0...n).each do |i|
      if i < n - 1
        puts "For want of a #{@words[i]} the #{@words[i + 1]} was lost."
      else
        puts "And all for the want of a #{@words.first}."
      end
    end
  end

  def gen
    build_proverb(*@words)
    puts "And all for the want of a #{@words.first}."
  end

  private

  def build_proverb(first, *words)
    return if words[0].nil?
    puts "For want of a #{first} the #{words[0]} was lost."
    build_proverb(*words)
  end
end

words = ["nail", "", "horse", "rider", "message", "battle", "kingdom"]

generator = ProverbGenerator.new(words)
generator.gen

puts

words2 = ["ipod", "remote", "pool stick", "watch", "keyboard"]

generator.words = words2
generator.gen
