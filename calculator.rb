#!/Users/keith/.rvm/rubies/ruby-2.2.0

equation = []
VALID_OPERATORS = ["+", "-", "*", "/", "(", ")", "="]

class String
  def valid_float?
    true if Float self rescue false
  end
end

class Float
  def prettify
    to_i == self ? to_i : self
  end
end

class Array
  def to_sentence(last_word_connector)
    i = 1
    num_elements = self.length
    results = ""
    self.each do |string|
      if i == num_elements
        results << "#{last_word_connector} #{string}"
      else
        results << "#{string}, "
      end
      i += 1
    end
    results
  end
end

def get_value
  input = ""
  loop do
    puts "Please enter your value:"
    input = gets.chomp
    if input.valid_float?
      break
    else
      puts "Your value, #{input}, was invalid. Please try again."
    end
  end
  input.to_f
end

def get_operator
  input = ""
  operators = ["+", "-", "*", "/", "(", ")", "="]
  last_word_connector = "or"
  loop do
    puts "Please enter your operator (#{operators.to_sentence(last_word_connector)}):"
    input = gets.chomp
    # TODO: add check for parentheticals
    break if VALID_OPERATORS.include?(input)
    puts "Your operator, #{input}, was invalid. Please try again."
  end
  input
end

def get_values(equation, index)
  values = []
  values << equation[index - 1]
  values << equation[index + 1]
  values
end

def delete_beside(equation, index)
  equation.delete_at(index + 1)
  equation.delete_at(index - 1)
  equation[0] = equation
end

def delete_between(start_index, end_index)

end

def calc_parens(eq_in_parens)

end

def parentheticals(equation)
  loop do
    break unless equation.include?("(")
    start_index = equation.index("(")
    end_index = equation.index(")")
    eq_in_parens = equation[start_index..end_index]
    puts "equation = #{equation}"
    equation = equation[0..start_index - 1] + equation[end_index + 1..-1]
    puts "equation = #{equation}"
    # TODO: send to function to calculate new value

    values = get_values(index)
    delete_beside(index)
    result = values.first * values.last
    equation[index - 1] = result
  end
  equation
end

def multiplication(equation)
  loop do
    break unless equation.include?("*")
    index = equation.index("*")
    values = get_values(equation, index)
    equation = delete_beside(equation, index)
    result = values.first * values.last
    equation[index - 1] = result
  end
  equation
end

def division(equation)
  loop do
    break unless equation.include?("/")
    index = equation.index("/")
    values = get_values(equation, index)
    equation = delete_beside(equation, index)
    result = values.first / values.last
    equation[index - 1] = result
  end
  equation
end

def addition_and_subtraction(equation)
  loop do
    break unless equation.include?("+") || equation.include?("-")
    values = get_values(equation, 1)
    if equation[1] == "+"
      results = values[0] + values[1]
    else
      results = values[0] - values[1]
    end
    equation = delete_beside(equation, 1)
    equation[0] = results
  end
  equation
end

# def print_equation
#   results = ""
#   $equation.each do |i|
#     results + i.to_s
#   end
#   puts "im returning #{results}"
#   results
# end

def gather_input
  input = []
  loop do
    input << get_value
    input << get_operator
    if input.include?("=")
      input.pop
      break
    end
  end
  input
end

original_equation = gather_input
equation = original_equation
equation = parentheticals(equation)
equation = multiplication(equation)
equation = division(equation)
equation = addition_and_subtraction(equation)

puts "#{original_equation} = #{equation.first.prettify}"
