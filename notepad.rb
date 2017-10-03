if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
current_path = File.dirname(__FILE__) + "/lib/"
require_relative current_path + 'post.rb'
require_relative current_path + 'task.rb'
require_relative current_path + 'memo.rb'
require_relative current_path + 'link.rb'

puts "Привет, я твой блокнот!"

puts "Что хотите записать в блокнот?"

choices = Post.post_types

choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = gets.chomp.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save

puts "Ваша запись сохранена!"
