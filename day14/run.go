package main

import "defrag"
import "fmt"

func main() {
  fmt.Println("Part1 - How Many 1's in the Grid?")
  seed := "ffayrhll"
  grid := defrag.SeedToGrid(seed)
  population := defrag.CountOccupiedBits(grid)
  fmt.Println("\t",population)
}
