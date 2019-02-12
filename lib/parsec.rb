require 'string_to_boolean_refinements'
require 'libnativemath'

module Parsec
  # This is the main class responsible to evaluate the equations
  class Parsec
    using StringToBooleanRefinements

    VERSION = '0.2.21'.freeze

    # evaluates the equation
    def self.eval_equation(equation)
      remove(equation, true)

      convert(Libnativemath.native_eval(equation))
    end

    # returns true or raise an error
    def self.validate_syntax!(equation)
      remove(equation)

      validate(Libnativemath.native_eval(equation), true)
    end

    # returns true or an error string
    def self.validate_syntax(equation)
      remove(equation)

      validate(Libnativemath.native_eval(equation), false)
    end

    private_class_method

    def self.remove(equation, new_line = false)
      equation.gsub!(/[\n\t\r]/, ' ')

      # The following regex remove all spaces that are not between quot marks
      # https://tinyurl.com/ybc7bng3
      equation.gsub!(/( |(".*?"))/, '\\2') if new_line == true
    end

    def self.convert(ans)
      case ans['value']
      when 'inf' then return 'Infinity'
      when '-inf' then return '-Infinity'
      when 'nan' then return ans['value']
      end

      case ans['type']
      when 'int'     then return ans['value'].to_i
      when 'float'   then return ans['value'].to_f
      when 'boolean' then return ans['value'].to_bool
      when 'string'  then return error_check(ans['value'])
      when 'complex' then return 'complex number' # Maybe future implementation
      when 'matrix'  then return 'matrix value'   # Maybe future implementation
      end
    end

    def self.error_check(output)
      raise SyntaxError, output.sub(/^Error: /, '') if output.match?(/^Error:/)
      output
    end

    def self.validate(ans, raise_error)
      if (ans['type'] == 'string') && ans['value'].match?(/^Error:/)
        raise SyntaxError, ans['value'].sub(/^Error: /, '') if raise_error
        return ans['value'].sub(/^Error: /, '')
      end
      true
    end
  end
end
