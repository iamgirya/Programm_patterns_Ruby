require 'yaml'

class StudentsListYaml

    def parse_to_student(line)
        Student.from_yaml(line)
    end

    def puts_student(student)
        vars = {}
        student.instance_variables.map do |attribute|
            vars[attribute.to_s[1..-1]]=student.instance_variable_get(attribute)
        end
        file.puts YAML(vars)
    end

  end