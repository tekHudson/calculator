#!/Users/keith/.rvm/rubies/ruby-2.2.0

$equation = []
VALID_OPERATORS = ["+", "-", "*", "/", "="]

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
  $equation << input.to_f
end

def get_operator
  input = ""
  loop do
    puts "Please enter your operator (+, -, * or /):"
    input = gets.chomp
    if VALID_OPERATORS.include?(input)
      break
    else
      puts "Your operator, #{input}, was invalid. Please try again."
    end
  end
  $equation << input
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
  loop do
    get_value
    get_operator
    if $equation.include?("=")
      # puts "Your equation #{print_equation}"
      $equation.pop
      break
    end
  end
end

#LETS DO THIS!
# loop do
  # $equation = []
  gather_input
  # break if $values.length > 1
  # puts "values = #{$values.length}"
  # puts "Your input failed... try again."
# end

def get_values(index)
  values = []
  values << $equation[index - 1]
  values << $equation[index + 1]
  values
end

def delete_elements(index)
  $equation.delete_at(index + 1)
  $equation.delete_at(index - 1)
end

def multiplication
  loop do
    break unless $equation.include?("*")
    index = $equation.index("*")
    values = get_values(index)
    delete_elements(index)
    result = values.first * values.last
    $equation[index - 1] = result
  end
end

def division
  loop do
    break unless $equation.include?("/")
    index = $equation.index("/")
    values = get_values(index)
    delete_elements(index)
    result = values.first / values.last
    $equation[index - 1] = result
  end
end

def addition_and_subtraction
  loop do
    break unless $equation.include?("+") || $equation.include?("-")
    values = get_values(1)
    if $equation[1] == "+"
      results = values[0] + values[1]
    else
      results = values[0] - values[1]
    end
    delete_elements(1)
    $equation[0] = results
  end
end

multiplication
division
addition_and_subtraction

puts $equation.first.prettify
