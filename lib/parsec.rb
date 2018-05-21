require 'string_to_boolean_refinements'
require 'libnativemath'

module EquationsParser
  class Parsec
    using StringToBooleanRefinements

    VERSION = '0.1.0'

    def eval_equation(equation)
      # This line removes all spaces that are not between quotation marks
      # https://stackoverflow.com/questions/205521/using-regex-to-replace-all-spaces-not-in-quotes-in-ruby?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
      #equation.gsub!(/( |(".*?"))/, "\\2")

      #output = `./bin/muparserx-macOS <<< '#{equation}'`
      #result = output.split('parsec> ', 2).last
      #result_type = result.split('type: \'', 2).last[0]
      #result_value = result.split('ans = ', 2).last.strip
      #convert(result_value, result_type)
      Libnativemath.native_eval(equation)
    end

    private

    def convert(value, type)
      case value
      when 'inf'  then return 'Infinity'
      when 'nan' then return value
      end
      case type
      when 'i'  then return value.to_i
      when 'f'  then return value.to_f
      when 'b'  then return value.to_bool
      when 's'  then return value.delete('\"')
      when 'c'  then return 'complex number'
      when ' '  then raise ArgumentError, value
      end
    end
  end
end
