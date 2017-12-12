package main

import "cpu"
import "fmt"

func main() {
  fmt.Println("Part 1 - Execute Instructions")
  list, _ := cpu.ParseInstructions("./input.txt")
  registers, max_register_value := cpu.RunInstructions(list)
  for key, value := range registers {
      fmt.Println("\tKey:", key, "Value:", value)
  }
  fmt.Println("Part 2 - Watch for largest register value")
  fmt.Println("\t", max_register_value)
}
