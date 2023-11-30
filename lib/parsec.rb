require 'string_to_boolean_refinements'
require 'libnativemath'

module Parsec
  # This is the main class responsible to evaluate the equations
  class Parsec
    using StringToBooleanRefinements

    VERSION = '0.14.0'.freeze

    # evaluates the equation and returns only the result
    def self.eval_equation(equation)
      eval_equation_with_type(equation)[:value]
    end

    # evaluates the equation and returns the result and its data type
    def self.eval_equation_with_type(equation)
      equation = sanitize(equation, true)

      result = Libnativemath.native_eval(equation)
      { value: convert(result), type: result['type'].to_sym }
    end

    # returns true or raise an error
    def self.validate_syntax!(equation)
      equation = sanitize(equation)

      validate(Libnativemath.native_eval(equation), true)
    end

    # returns true or an error string
    def self.validate_syntax(equation)
      equation = sanitize(equation)

      validate(Libnativemath.native_eval(equation), false)
    end

    def self.get_result_type(equation)
      equation = sanitize(equation, true)

      result = Libnativemath.native_eval(equation)
      result['type'].to_sym if validate(result, true)
    end

    private_class_method

    def self.sanitize(equation, new_line = false)
      equation = equation.gsub(/[\n\t\r]/, ' ')

      # The following regex remove all spaces that are not between quot marks
      # https://tinyurl.com/ybc7bng3
      if new_line == true
        equation.gsub!(/( |("([^"\\]|\\.)*")|('([^'\\]|\\.)*'))/, '\\2')
      end

      equation
    end

    def self.convert(ans)
      case ans['value']
      when 'inf' then return 'Infinity'
      when '-inf' then return '-Infinity'
      when 'nan', '-nan' then return 'nan'
      end

      case ans['type']
      when 'int'     then return ans['value'].to_i
      when 'float'   then return ans['value'].to_f
      when 'boolean' then return ans['value'].to_bool
      when 'string'  then return error_check(ans['value'].force_encoding(Encoding::UTF_8))
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
