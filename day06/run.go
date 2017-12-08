package main
import "fmt"
import "realloc"

func main() {
  fmt.Println("Part 1 => How long until we repeat a state?")
  banks := []int{10,3,15,10,5,15,5,15,9,2,5,8,5,2,3,6}
  fmt.Println("\tmemory banks: ",banks)
  total_steps, steps_between := realloc.BalanceUntilRepeat(banks)
  fmt.Println("\t",total_steps," steps before we repeated the ",banks, " step")

  fmt.Println("Part 2 => How many steps between the repeated states?")
  fmt.Println("\t",steps_between," steps between the repeat")
}
