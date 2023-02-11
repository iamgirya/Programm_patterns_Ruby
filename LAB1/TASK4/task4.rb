# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента.
def indOfMinEl(arr)
  return arr.index(arr.min)
end

# 1.14 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.

# 1.26 Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.

# 1.38 Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, 
# значение которых принадлежит этому отрезку.

# 1.50. Для двух введенных списков L1 и L2 построить новый список, состоящий из элементов,
# встречающихся только в одном из этих списков и не повторяющихся в них.

# arr = [4,6,1,7,3,5,6,1,2,4,3]
puts "Введите массив для обработки"
arr = gets.chomp.split(' ').map(&:to_i)
puts "Введённый массив: #{arr.inspect}"

puts "Какую задачу решать?

1 - индекс минимального элемента
2 - количество элементов в интервале
3 - количество элементов между первым и последним минимальным
4 - количество элементов, значение которых принадлежит отрезку
5 - новый список, состоящий из элементов, встречающихся только в одном из этих списков и не повторяющихся в них"
n = gets.chomp.to_i

if (n == 2 || n == 4) then
  puts "Введите интервал"
  ab = gets.chomp.split(' ').map(&:to_i)
  puts "Введённый интервал: #{ab}"
end

case n
when 1
  puts "Результат: #{indOfMinEl(arr)}"
when 2
  puts "Результат: #{indOfMinEl(arr, ab)}"
when 3
  puts "Результат: #{indOfMinEl(arr)}"
when 4
  puts "Результат: #{indOfMinEl(arr, ab)}"
when 5
  puts "Результат: #{indOfMinEl(arr)}"
end