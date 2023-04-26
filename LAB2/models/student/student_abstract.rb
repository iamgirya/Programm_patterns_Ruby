# frozen_string_literal: true

require_relative '../../support/meta_code'

class AbstractStudent
  attr_reader :git, :contact, :id

  getter :fio, :git, :contact, :id

  def get_info
    "#{get_fio};#{get_contact};#{get_git}"
  end

  def to_s
    vars = {}
    instance_variables.map do |attribute|
      vars[attribute.to_s[1..]] = instance_variable_get(attribute)
    end
    JSON(vars)
  end
end
