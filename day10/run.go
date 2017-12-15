package main

import "knot"
import "fmt"

func main() {
  fmt.Println("Part1 - Knot Hash")
  lengths := []int{206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3}
  k := knot.New(256)
  for i:=0; i<16; i++ {
    k = knot.Twist(k, lengths[i])
  }
  numbers := knot.Numbers(k)
  fmt.Println("\tanswer = ",numbers[0] * numbers[1])

  fmt.Println("Part2 - Generating Dense Hashes")
  input := "206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3"
  fmt.Println("\t",input," => ",knot.Hash(input))
}
