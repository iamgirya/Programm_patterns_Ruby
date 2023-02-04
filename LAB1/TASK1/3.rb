system "color A"
require 'open3'

puts "Введите команду для выполнения её OS, например ls"
cmd = gets.chomp()
system( cmd )
puts "Теперь введите некоторый код на Ruby для выполнения самой же Ruby"
rubyCmd = gets.chomp()
File.open("TASK1/code.rb","w") do |file|
    file.write(rubyCmd)
end
cmd2 = "ruby TASK1/code.rb"
system(cmd2)