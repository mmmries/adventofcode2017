package knot

import "fmt"

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

func Hash(input string) string {
  lengths := inputToLengths(input)
  knot := New(256)
  for i:=0; i<64; i++ {
    for j:=0; j<len(lengths); j++ {
      knot = Twist(knot, int(lengths[j]))
    }
  }
  var dense [16]byte
  for i:=0; i<16; i++ {
    value := byte(knot.numbers[i * 16])
    for j:=1; j<16; j++ {
      offset := (i*16) + j
      value = value ^ byte(knot.numbers[offset])
    }
    dense[i] = value
  }
  return fmt.Sprintf("%x", dense)
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

func inputToLengths(input string) []byte {
  lengths := make([]byte, len(input) + 5)
  for i := 0; i < len(input); i++ {
    lengths[i] = input[i]
  }
  lengths[len(input)] = 17
  lengths[len(input) + 1] = 31
  lengths[len(input) + 2] = 73
  lengths[len(input) + 3] = 47
  lengths[len(input) + 4] = 23
  return lengths
}
