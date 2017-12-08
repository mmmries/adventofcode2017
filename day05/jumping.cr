class Jumping
  def self.steps_to_exit(instructions)
    new(instructions).steps_to_exit
  end

  @instructions : Array(Int32)

  def initialize(instructions)
    @instructions = instructions
    @number_of_instructions = 0
    @current_location = 0
  end

  def steps_to_exit
    loop do
      break if out_of_instructions?
      execute_instruction
    end
    @number_of_instructions
  end

  def execute_instruction
    jump_vector = @instructions[@current_location]
    @instructions[@current_location] += 1
    @current_location += jump_vector
    @number_of_instructions += 1
  end

  def out_of_instructions?
    @current_location < 0 || @current_location >= @instructions.size
  end
end
