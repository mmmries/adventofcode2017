package spiral_memory
import "testing"

func TestOriginPositioning(t *testing.T) {
  expected := Position{0, 0}
  actual := GridPosition(1)
  if actual != expected {
    t.Errorf("Expected square 1 to be at position %#v, but was at %#v", expected, actual)
  }
}

func TestGridPositioning(t *testing.T) {
  expected := Position{0,1}
  actual := GridPosition(4)
  if actual != expected {
    t.Errorf("Expected 4 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{-1,0}
  actual = GridPosition(6)
  if actual != expected {
    t.Errorf("Expected 6 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{1,-1}
  actual = GridPosition(9)
  if actual != expected {
    t.Errorf("Expected 9 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{2,-1}
  actual = GridPosition(10)
  if actual != expected {
    t.Errorf("Expected 10 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{2,1}
  actual = GridPosition(12)
  if actual != expected {
    t.Errorf("Expected 12 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{-2,2}
  actual = GridPosition(17)
  if actual != expected {
    t.Errorf("Expected 17 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{-2,-1}
  actual = GridPosition(20)
  if actual != expected {
    t.Errorf("Expected 20 be at %#v but was at %#v", expected, actual)
  }
  expected = Position{0,-2}
  actual = GridPosition(23)
  if actual != expected {
    t.Errorf("Expected 23 be at %#v but was at %#v", expected, actual)
  }
}

func TestGridDistance(t *testing.T) {
  if GridDistance(1) != 0 {
    t.Errorf("Expected 1 to have a distance of 0")
  }
  if GridDistance(4) != 1 {
    t.Errorf("Expected 4 to have a distance of 1")
  }
  if GridDistance(7) != 2 {
    t.Errorf("Expected 7 to have a distance of 2")
  }
  if GridDistance(12) != 3 {
    t.Errorf("Expected 12 to have a distance of 3")
  }
  if GridDistance(1024) != 31 {
    t.Errorf("Expected 1024 to have a distance of 31")
  }
}

func TestCumulativeValueFinding(t *testing.T) {
  if FindValueWithGreaterCumulativeValueThan(1) != 2 {
    t.Errorf("Expected value 2 to have a value greater than 1")
  }
  if FindValueWithGreaterCumulativeValueThan(4) != 5 {
    t.Errorf("Expected value 5 to have a value greater than 4")
  }
  if FindValueWithGreaterCumulativeValueThan(24) != 25 {
    t.Errorf("Expected value 25 to have a value greater than 25")
  }
  if FindValueWithGreaterCumulativeValueThan(57) != 59 {
    t.Errorf("Expected value 59 to have a value greater than 57")
  }
  if FindValueWithGreaterCumulativeValueThan(360) != 362 {
    t.Errorf("Expected value 362 to have a value greater than 360")
  }
  if FindValueWithGreaterCumulativeValueThan(800) != 806 {
    t.Errorf("Expected value 806 to have a value greater than 800")
  }
}
