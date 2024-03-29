# frozen_string_literal: true
require 'json'
require 'yaml'
require_relative "../../support/meta_code"
require_relative "./student_abstract.rb"

class Student < AbstractStudent
    attr_writer :id
    attr_validate_accessor :phone, '/^\+?[7,8] ?\(?\d{3}\)?-?\d{3}-?\d{2}-?\d{2}$/'
    attr_validate_accessor :email, '/\w*@\w*.\w{2,3}/'
    attr_validate_accessor :telegram, '/@\w*/'
    attr_validate_accessor :git, '/@\w*/'
    attr_validate_accessor :last_name, '/^[А-Я][а-я]+$/'
    attr_validate_accessor :first_name, '/^[А-Я][а-я]+$/'
    attr_validate_accessor :paternal_name, '/^[А-Я][а-я]+$/'

    def initialize(last_name, first_name, paternal_name, options = {})
      self.last_name = last_name
      self.first_name = first_name
      self.paternal_name = paternal_name
      self.id = options[:id] == 'NULL' ? nil : options[:id]
      self.phone = options[:phone] == 'NULL' ? nil : options[:phone]
      self.git = options[:git] == 'NULL' ? nil : options[:git]
      self.telegram = options[:telegram] == 'NULL' ? nil : options[:telegram]
      self.email = options[:email] == 'NULL' ? nil : options[:email]
    end

    attr_is_have_reader :fio
    def fio
      "#{last_name} #{first_name.upcase[0]}. #{paternal_name.upcase[0]}."
    end

    attr_is_have_reader :contact
    def contact
      return "#{phone}" unless phone.nil?
      return "#{telegram}" unless telegram.nil?
      return "#{email}" unless email.nil?
      nil
    end

    def validate
      git? && contact?
    end

    def set_contacts(contacts)
      self.phone = contacts[:phone] if contacts.key?(:phone)
      self.telegram = contacts[:telegram] if contacts.key?(:telegram)
      self.email = contacts[:email] if contacts.key?(:email)
    end
  
    def self.from_json(str)
      unless str.is_a?(String)
        str = JSON.pretty_generate(str)
      end
      result = JSON.parse(str)
      raise ArgumentError, 'Missing fields: last_name, first_name, paternal_name' unless result.key?('first_name') && result.key?('last_name') && result.key?('paternal_name')

      last_name = result.delete('last_name')
      first_name = result.delete('first_name')
      paternal_name = result.delete('paternal_name')
      Student.new(last_name, first_name, paternal_name, **result.transform_keys(&:to_sym))
    end

    def self.from_yaml(str)
      result = YAML.load(str)
      raise ArgumentError, 'Missing fields: last_name, first_name, paternal_name' unless result.key?('first_name') && result.key?('last_name') && result.key?('paternal_name')

      last_name = result.delete('last_name')
      first_name = result.delete('first_name')
      paternal_name = result.delete('paternal_name')
      Student.new(last_name, first_name, paternal_name, **result.transform_keys(&:to_sym))
    end

    def self.read_from_txt(file_path)
      arr = []
      begin
        File.foreach(file_path) do |line|
          arr += [Student.from_json(line)]
        end
        return arr
      rescue => exception
        raise "File not found at the given address #{file_path}. Exception: #{exception.message}"
      end
    end

    def self.write_to_txt(file_path, students)
      begin
        File.open(file_path, 'w') do |file|
          students.each do |student|
            file.puts student.to_s
          end
        end
      rescue => exception
        raise "Error writing to file at the given address #{file_path}. Exception: #{exception.message}"
      end
    end

  end