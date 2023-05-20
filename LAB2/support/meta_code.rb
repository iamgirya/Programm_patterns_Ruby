def getter(*methods)
    methods.each do |method|
    class_eval %{
        def get_#{method}
            "#{method}:#\{#{method}\}"
        end
    }
    end
end

def private_attr_writer(*methods)
    methods.each do |method|
    class_eval %{
        attr_writer :#{method};private :#{method}=
    }
    end
end

def private_attr_accessor(*methods)
    methods.each do |method|
    class_eval %{
        attr_accessor :#{method};private :#{method}=
    }
    end
end

def attr_validate_reader(methods, regex)
    class_eval %{
        def #{methods}
            @#{methods}
        end
        def self.validate_#{methods}?(value)
            value.match(#{regex})
        end
        def #{methods}?
            !@#{methods}.nil?
        end
    }
end

def attr_validate_accessor(methods, regex)
    class_eval %{
        def #{methods}=(new_value)
            if new_value == nil || new_value !~ #{regex}
                raise ArgumentError
            end
            @#{methods} = new_value
        end
        attr_validate_reader :#{methods}, '#{regex}'
    }
end

def attr_is_have_reader(methods)
    class_eval %{
        def #{methods}
            @#{methods}
        end
        def #{methods}?
            !@#{methods}.nil?
        end
    }
end