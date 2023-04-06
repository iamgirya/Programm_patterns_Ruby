class AbstractStudent
    attr_reader :git, :contact, :id

    getter :fio, :git ,:contact, :id

    def get_info
        self.get_fio()+";"+self.get_contact()+";"+self.get_git()
    end

    def to_s
        vars = {}
        self.instance_variables.map do |attribute|
            vars[attribute.to_s[1..-1]]=self.instance_variable_get(attribute)
        end
        return JSON(vars)
    end
end