require 'set'
# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента.
def indOfMinEl(arr)
  return arr.index(arr.min)
end
# 1.14 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
def countOfElInInterval(arr, interval)
  return (arr.select {|element| (element >= interval[0] && element <= interval[1])  }).length
end
# 1.26 Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.
def countOfElBetweenFirstMinAndSecondMin(arr)
  firstMinIndex = arr.index(arr.min)
  tmpArr = arr.difference()
  tmpArr.delete_at(firstMinIndex)
  secondMinIndex = tmpArr.index(tmpArr.min)
  if (firstMinIndex > secondMinIndex) then
    firstMinIndex-=1
  end
  return (firstMinIndex-secondMinIndex).abs
end


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
if (n == 5) then
  puts "Введите второй список"
  arr2 = gets.chomp.split(' ').map(&:to_i)
  puts "Введённый интервал: #{arr2}"
end

case n
when 1
  puts "Результат: #{indOfMinEl(arr)}"
when 2
  puts "Результат: #{countOfElInInterval(arr, ab)}"
when 3
  puts "Результат: #{countOfElBetweenFirstMinAndSecondMin(arr)}"
when 4
  puts "Результат: #{countOfElInOtrezok(arr, ab)}"
when 5
  puts "Результат: #{delta(arr, arr2)}"
end