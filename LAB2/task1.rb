# frozen_string_literal: true
require_relative 'student'
require_relative 'student_short'
require_relative 'data_list_short'
student1 = Student.new('Полетов', 'Разбор', 'Алексеевич')
student2 = Student.new('Пиндосов', 'Облом', 'Баракович', { id: 1, telegram: '@fakk_usa' })
student3 = Student.new('Атому', 'Ли', 'Ядала', { phone: '79181461800', email: 'goaloffway@mail.ru', git: '@vitaliyg' })
student4 = Student.new('Гераклов', 'Поход', 'Подвигоевич', {id: 12, phone: '79698876534'})
student5 = Student.new('Братанов', 'Друган', 'Кентович', {id: 77, phone: '+7 (777)-777-77-77'})
student6 = Student.read_from_txt('test.txt')
puts student1
puts student2
puts student3
puts student4
puts student5
puts Student.validate_phone?('79181461800')
puts Student.validate_phone?('+9 (777)-777-77-77')
puts Student.validate_git?('@r1411')
puts Student.validate_email?('s0160151@edu.kubsu.ru')
puts student3.git?

student1.set_contacts({telegram: '@waasabi13'})
puts student1.last_name

puts student5.get_info

st3 = StudentShort.from_student(student3)
st4 = StudentShort.from_json('{"fio": "Гиренко Д.Е.", "id":1}')
puts st4.get_info
puts st4.to_s
puts StudentShort.from_json(st4.to_s)
puts student1.contact
puts student1.fio
puts student6[1].get_info
Student.write_to_txt('test2.txt', student6)

short_array = [
    StudentShort.new(id: 0, fio: "Aa Bb Cc", git: "@abc", contact: "abc@vk.com"),
    StudentShort.new(id: 0, fio: "Afrl Advm Apgmti", git: "@aaa", contact: "aaa@vk.com"),
]

list = DataListStudentShort.new(
    list: short_array,
)
list.select(1)
puts list.get_selected_objects.map { |x| x.to_s }
puts list.get_names
puts list.get_data