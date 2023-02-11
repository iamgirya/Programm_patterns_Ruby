#Метод 1 Найти количество чисел, взаимно простых с заданным.
#Метод 2 Найти сумму цифр числа, делящихся на 3
#Метод 3 Найти делитель числа, являющийся взаимно простым с
#наибольшим количеством цифр данного числа.

def nod(a, b) 
    if (b == 0) then a
    else nod(b, a % b)
    end
end

def simple(a, b) 
    1 == nod(a, b)
end

def euler(n, m = n, acc = 1) #функция Эйлера
    if m == 1 then acc
    else euler(n, m-1, (simple(n, m) ? 1:0 ) + acc)
    end
end

def sum(num)
    rez= 0
    num.digits.each { 
        |dig| 
        if dig % 3 == 0
            puts dig
            rez += dig 
            puts dig
        end
    }
    return rez
end

def otv(n)
    divisors = (2...n).select{|numbers| n%numbers == 0}
    count=0
    array=[]
    for i in divisors do
        n.digits.each { 
                    |dig| 
                    if simple(i,dig)
                        count+=1
                    end
                }
        array<<count       
    end
    return array.max
end

def minArr(arr)
min = arr.min
return min
end

def firstPos(arr)
    for i in 0..arr.length
        return i if arr[i].to_i > 0
    end
    return -1
end



puts "Введите входные данные\n"
input = gets.chomp().split(' ').map(&:to_i)[0]
puts "Введите номер задания\n"
method = gets.chomp()

case method
when "1"
    puts "Найти количество чисел, взаимно простых с заданным: #{euler(input)}"
when "2"
    puts "Найти сумму цифр числа, делящихся на 3: #{sum(input)}"
when "3"
    puts "Найти делитель числа, являющийся взаимно простым с
    наибольшим количеством цифр данного числа: #{otv(input)}"
else 
    puts "Метода под номером #{method} не существует"
end