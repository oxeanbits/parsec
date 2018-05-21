require 'string_to_boolean_refinements'
require 'libnativemath'

module EquationsParser
  class Parsec
    using StringToBooleanRefinements

    VERSION = '0.2.3'

    def self.eval_equation(equation)
      # This line removes all spaces that are not between quotation marks
      # https://stackoverflow.com/questions/205521/using-regex-to-replace-all-spaces-not-in-quotes-in-ruby?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
      equation.gsub!(/( |(".*?"))/, "\\2")

      convert(Libnativemath.native_eval(equation))
    end

    private_class_method

    def self.convert(ans)
      case ans["value"]
      when 'inf'  then return 'Infinity'
      when 'nan' then return ans["value"]
      end

      case ans["type"]
      when 'int'  then return ans["value"].to_i
      when 'float'  then return ans["value"].to_f
      when 'boolean'  then return ans["value"].to_bool
      when 'string'  then return ans["value"].delete('\"')
      when 'c'  then return 'complex number'
      when ' '  then raise ArgumentError, ans["value"]
      end
    end
  end
end
