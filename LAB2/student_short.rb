# frozen_string_literal: true
require 'json'
require_relative "./meta_code.rb"
require_relative "./student_abstract.rb"

class StudentShort < AbstractStudent
    attr_reader :fio
    private_attr_writer :git, :contact, :id, :fio

    def initialize(id:, fio:, git:, contact:)
        self.id = id
        self.fio = fio
        self.git = git
        self.contact = contact
    end

    def self.from_student(student) 
        StudentShort.new(
            id: student.id, 
            fio: "#{student.first_name} #{student.last_name.upcase[0]}. #{student.paternal_name.upcase[0]}.",
            git: student.git,
            contact: student.contact
        )
    end

    def self.from_json(json)
      result = JSON.parse(json)
      raise ArgumentError, 'Missing field: fio' unless result.key?('fio')

      fio = result.delete('fio')
      StudentShort.new(
        id: result['id'],
        fio: fio,
        git: result['git'],
        contact: result['contact']
      )
    end    
end