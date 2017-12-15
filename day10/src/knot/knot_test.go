package knot

import "testing"

func TestSimpleKnot(t *testing.T) {
  expected := []int{0,1,2,3,4}
  knot := New(5)
  if !IntArrayEquals(knot.numbers, expected) {
    t.Errorf("knot got messed up %v should have been %v", knot.numbers, expected)
  }

  knot = Twist(knot, 3)
  expected = []int{2, 1, 0, 3, 4}
  if !IntArrayEquals(knot.numbers, expected) {
    t.Errorf("knot got messed up %v should have been %v", knot.numbers, expected)
  }

  knot = Twist(knot, 4)
  expected = []int{4, 3, 0, 1, 2}
  if !IntArrayEquals(knot.numbers, expected) {
    t.Errorf("knot got messed up %v should have been %v", knot.numbers, expected)
  }

  knot = Twist(knot, 1)
  expected = []int{4, 3, 0, 1, 2}
  if !IntArrayEquals(knot.numbers, expected) {
    t.Errorf("knot got messed up %v should have been %v", knot.numbers, expected)
  }

  knot = Twist(knot, 5)
  expected = []int{3, 4, 2, 1, 0}
  if !IntArrayEquals(knot.numbers, expected) {
    t.Errorf("knot got messed up %v should have been %v", knot.numbers, expected)
  }
  if knot.skip_size != 4 {
    t.Errorf("messed up skip_size")
  }
  if knot.current_position != 19 {
    t.Errorf("messed up current_position")
  }
}

func IntArrayEquals(a []int, b []int) bool {
    if len(a) != len(b) {
        return false
    }
    for i, v := range a {
        if v != b[i] {
            return false
        }
    }
    return true
}
