package main

import "cpu"
import "fmt"

func main() {
  fmt.Println("Part 1 - Execute Instructions")
  list, _ := cpu.ParseInstructions("./input.txt")
  registers := cpu.RunInstructions(list)
  for key, value := range registers {
      fmt.Println("\tKey:", key, "Value:", value)
  }
}
