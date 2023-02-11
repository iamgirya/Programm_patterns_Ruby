def minArr(arr)
    min = arr[0]
    for i in 0..arr.length-1
        min = arr[i] if arr[i] < min
    end
    return min
end

def posFirst(arr)
    for i in 0..arr.length
        return i+1 if arr[i].to_i > 0
    end
    return -1
end

if ARGV.count < 2
    puts "нет аргументов"
    return
end

method = ARGV[0]
path = ARGV[1]

file = File.open(path)
array = file.readline.split(' ').map(&:to_i)

puts "Массив, #{array}\n"
case method
when "1"
    puts "Минимальный: #{minArr(array)}"
when "2"
    puts "Номер первого положительного: #{posFirst(array)}"
else 
    puts "Такого метода нет"
end