package knot

type Knot struct {
  numbers []int
  current_position int
  skip_size int
}

func New(length int) Knot {
  numbers := make([]int, length)
  for i := 0; i < length; i++ {
    numbers[i] = i
  }
  return Knot{numbers, 0, 0}
}

func Numbers(knot Knot) []int {
  return knot.numbers
}

func Twist(knot Knot, length int) Knot {
  sublist := make([]int, length)
  pos := knot.current_position
  size := len(knot.numbers)
  for i:= 0; i < length; i++ {
    j := (pos + i) % size
    sublist[i] = knot.numbers[j]
  }
  for i:=0; i < length; i++ {
    j := (pos + length - i - 1) % size
    knot.numbers[j] = sublist[i]
  }
  knot.current_position = pos + length + knot.skip_size
  knot.skip_size += 1
  return knot
}
