require 'minitest/autorun'
require './models/student/student'
class TestStudent < Minitest::Test
  def test_initialize_raises_error_with_wrong_tg
    assert_raises(ArgumentError) { Student.new('Ку', 'Пу', 'Иу', **{ id: 4, telegram: '123' }) }
  end

  def test_initialize_raises_error_with_last_name
    assert_raises(ArgumentError) { Student.new(nil, 'Ми', 'Ки', **{ id: 3, telegram: '@gameover' }) }
  end

  def test_initialize_raises_error_with_first_name
    assert_raises(ArgumentError) { Student.new('Ху', nil, 'По', **{ id: 2, telegram: '@gameover' }) }
  end

  def test_initialize_raises_error_with_father_name
    assert_raises(ArgumentError) { Student.new('Ху', 'Лу', nil, **{ id: 1, telegram: '@gameover' }) }
  end

  def test_book_attributes_are_set
    student = Student.new('Ху', 'Лу', 'Pu', **{ id: 1, telegram: '@gameover' })

    assert_equal 1, student.id
    assert_equal 'Ху', student.last_name
    assert_equal 'Лу', student.first_name
    assert_equal 'Pu', student.father_name
    assert_equal '@gameover', student.telegram
  end
end
