require 'string_to_boolean_refinements'
require 'libnativemath'

module Parsec
  # This is the main class responsible to evaluate the equations
  class Parsec
    using StringToBooleanRefinements

    VERSION = '0.2.19'.freeze

    # evaluates the equation
    def self.eval_equation(equation)
      remove_spaces(equation)

      convert(Libnativemath.native_eval(equation))
    end

    # returns true or raise an error
    def self.validate_syntax(equation)
      validate(Libnativemath.native_eval(equation), true)
    end

    # returns true or an error string
    def self.verify_syntax(equation)
      validate(Libnativemath.native_eval(equation), false)
    end

    private_class_method

    def self.remove_spaces(equation)
      # This line removes all spaces that are not between quotation marks
      # https://stackoverflow.com/questions/205521/using-regex-to-replace-all-spaces-not-in-quotes-in-ruby?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
      equation.gsub!(/( |(".*?"))/, '\\2')
    end

    def self.convert(ans)
      case ans['value']
      when 'inf' then return 'Infinity'
      when 'nan' then return ans['value']
      end

      case ans['type']
      when 'int'     then return ans['value'].to_i
      when 'float'   then return ans['value'].to_f
      when 'boolean' then return ans['value'].to_bool
      when 'string'  then return error_check(ans['value'])
      when 'c'       then return 'complex number'
      end
    end

    def self.error_check(output)
      raise SyntaxError, output.sub('Error: ', '') if output.include?('Error')
      output.delete('\"')
    end

    def self.validate(ans, raise_error)
      if (ans['type'] == 'string') && ans['value'].include?('Error: ')
        raise SyntaxError, ans['value'].sub('Error: ', '') if raise_error
        return ans['value'].sub('Error: ', '')
      end
      true
    end
  end
end
