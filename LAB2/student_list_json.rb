class StudentsListBase
    attr_accessor :students
    
    def initialize
      self.students = []
    end
  
    def read_from_txt(file_path)
        students = []
        begin
            File.foreach(file_path) do |line|
                students += [Student.from_json(line)]
            end
        rescue => exception
            raise "File not found at the given address #{file_path}. Exception: #{exception.message}"
        end
    end

    def write_to_txt(file_path)
        begin
            File.open(file_path, 'w') do |file|
            students.each do |student|
                vars = {}
                student.instance_variables.map do |attribute|
                    vars[attribute.to_s[1..-1]]=student.instance_variable_get(attribute)
                end
                file.puts JSON(vars)
            end
            end
        rescue => exception
            raise "Error writing to file at the given address #{file_path}. Exception: #{exception.message}"
        end
    end
  
    def student_by_id(student_id)
      students.detect { |s| s.id == student_id }
    end

    def sorted
        students.sort_by(&:fio)
    end
  
    def add_student(student)
        student.id = students.max_by(&:id).id + 1
        students << student
    end
    
    def replace(student_id, student)
      idx = student.find_index { |s| s.id == student_id }
      students[idx] = student
    end
  
    def remove(student_id)
      students.reject! { |s| s.id == student_id }
    end
  
    def get_student_short_count
      students.count
    end
  
    # Получить page по счету count элементов (страница начинается с 1)
    def get_k_n_student_short_list(page, count, existing_data_list: nil)
      offset = (page - 1) * count
      slice = students[offset, count].map { |s| StudentShort.from_student(s) }
  
      return DataListStudentShort.new(slice) if existing_data_list.nil?
  
      existing_data_list.append(slice)
    end
  
  end