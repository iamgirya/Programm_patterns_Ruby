class StudentsListJson < StudentsListBase

    def parse_to_student(line)
        Student.from_json(line)
    end

    def puts_student(student)
        vars = {}
        student.instance_variables.map do |attribute|
            vars[attribute.to_s[1..-1]]=student.instance_variable_get(attribute)
        end
        file.puts JSON(vars)
    end
  
  end