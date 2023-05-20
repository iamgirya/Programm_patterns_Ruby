require 'yaml'
require 'json'

class DataTransformer

  MESS = "SYSTEM ERROR: method missing"
  def parse_to_student(line); raise MESS; end

  def puts_student(student); raise MESS; end

end

class DataTransformerYaml < DataTransformer

  def parse_to_student(line)
    Student.from_yaml(line)
  end

  def puts_student(student)
    vars = {}
    student.instance_variables.map do |attribute|
      vars[attribute.to_s[1..-1]]=student.instance_variable_get(attribute)
    end
    (vars).to_yaml
  end

end

class DataTransformerJson < DataTransformer

  def parse_to_student(line)
    Student.from_json(line)
  end

  def puts_student(student)
    vars = {}
    student.instance_variables.map do |attribute|
      vars[attribute.to_s[1..-1]]=student.instance_variable_get(attribute)
    end
    JSON(vars)
  end

end