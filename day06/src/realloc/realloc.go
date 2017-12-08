package realloc

import "container/list"
import "strconv"

func BalanceUntilRepeat(banks []int) (int,int) {
  total_steps := 0
  steps_beteween_repeat := -1
  history := list.New()
  for {
    SingleBalance(banks)
    total_steps++
    str := ToString(banks)
    steps_beteween_repeat = AlreadySeenThis(history, str)
    if steps_beteween_repeat > -1 {
      break
    }
    history.PushBack(str)
  }
  return total_steps, steps_beteween_repeat
}

func SingleBalance(banks []int) {
  index_to_distribute := FindLargestIndex(banks)
  to_distribute := banks[index_to_distribute]
  banks[index_to_distribute] = 0
  current := index_to_distribute + 1
  for {
    if current == len(banks) {
      current = 0
    }
    if to_distribute == 0 {
      break
    }
    banks[current]++
    current++
    to_distribute--
  }
}

func FindLargestIndex(banks []int) int {
  biggest_index := 0
  biggest_value := 0
  for i := 0; i < len(banks); i++ {
    if banks[i] > biggest_value {
      biggest_value = banks[i]
      biggest_index = i
    }
  }
  return biggest_index
}

func ToString(banks []int) string {
  str := ""
  for i := 0; i < len(banks); i++ {
    str += strconv.Itoa(banks[i])
  }
  return str
}

func AlreadySeenThis(history *list.List, str string) int {
  seen_it := false
  steps_ago := 1
  for e := history.Back(); e != nil; e = e.Prev() {
    if e.Value == str {
      seen_it = true
      break
    }
    steps_ago++
  }
  if seen_it {
    return steps_ago
  } else {
    return -1
  }
}
