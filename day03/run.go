package main

import "fmt"
import "spiral_memory"

func main() {
  fmt.Println("Part 1 - Manhattend Distance to Spiral Memory location 289326")
  fmt.Printf("\t%d\n", spiral_memory.GridDistance(289326))
  fmt.Println("Part 2 - First location with a cumulative value > 289326")
  fmt.Printf("\t%d\n", spiral_memory.FindValueWithGreaterCumulativeValueThan(289326))
}
