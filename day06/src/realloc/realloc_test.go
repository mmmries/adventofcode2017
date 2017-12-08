package realloc

import "testing"
import "reflect"

func TestSmallRebalance(t *testing.T) {
  to_balance := []int{0,2,7,0}
  expected := []int{2,4,1,2}
  total_steps, steps_between := BalanceUntilRepeat(to_balance)
  if total_steps != 5 {
    t.Errorf("Expected to repeat after 5 steps, but got %d", total_steps)
  }
  if steps_between != 4 {
    t.Errorf("Expected to repeat with 4 steps between, but got %d", steps_between)
  }
  if !reflect.DeepEqual(to_balance, expected) {
    t.Errorf("Expected to repeat the memory banks with {2,4,1,2}, but got %#v", to_balance)
  }
}
