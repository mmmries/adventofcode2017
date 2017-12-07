package spiral_memory

type Position struct {
  x int
  y int
}

func GridDistance(index int) int {
  position := GridPosition(index)
  x := position.x
  if x < 0 {
    x = x * -1
  }
  y := position.y
  if y < 0 {
    y = y * -1
  }
  return x + y
}

func GridPosition(index int) Position {
  i := 1
  ring := 0
  for {
    if i >= index {
      break
    }
    ring++
    i += ring * 8
  }
  if ring == 0 {
    return Position{0, 0}
  } else {
    cumulative_size_of_last_ring := i - (ring * 8)
    offset := (index - 1) - cumulative_size_of_last_ring
    side := offset / (ring * 2)
    side_offset := offset % (ring * 2)
    x := 0
    y := 0
    switch side {
      case 0:
        x = ring
        y = (-1 * (ring - 1)) + side_offset
      case 1:
        x = (ring - 1) - side_offset
        y = ring
      case 2:
        x = -1 * ring
        y = (ring - 1) - side_offset
      case 3:
        x = ((-1 * ring) + 1) + side_offset
        y = -1 * ring
    }
    return Position{x, y}
  }
}
