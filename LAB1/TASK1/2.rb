system "color A" 

if ARGV.count < 1
    puts "Введите Ваше имя"
    return 
end
  
user = ARGV[0]
puts "Хай, #{user}!"
puts "Какой у вас любимый язык программирования?"
lang = STDIN.gets.chomp.downcase

if lang == "ruby"
    puts "Вы подлиза, нехорошо так!😃"
elsif lang == "python"
    puts "Змееносец Вам имя!, но скоро будет Руби"
elsif lang == "c#"
    puts "Базировано! Но скоро будет Руби"
elsif lang == "pascal"
    puts "Уроки сделал? Кстати, скоро будет Руби"
else 
    puts "Скоро будет ruby👍"
end