package cpu

import (
  "container/list"
  "fmt"
  "io/ioutil"
  "strconv"
  "strings"
)

type Instruction struct {
  register string
  operator string
  value int
  conditional_source string
  conditional_operator string
  conditional_value int
}

func ParseInstructions(filename string) (*list.List,error) {
  data, err := ioutil.ReadFile(filename)
  if err != nil {
    return nil, err
  }
  lines := strings.Split(string(data), "\n")
  instructions := list.New()
  for i := 0; i < len(lines); i++ {
    if len(lines[i]) > 0 {
      parts := strings.Split(lines[i], " ")
      value, _ := strconv.Atoi(parts[2])
      cond_value, _ := strconv.Atoi(parts[6])
      inst := Instruction{parts[0], parts[1], value, parts[4], parts[5], cond_value}
      instructions.PushBack(inst)
    }
  }
  return instructions, nil
}

func RunInstructions(instructions *list.List) (map[string]int, int) {
  registers := make(map[string]int)
  max_register_value := -10000
  for e := instructions.Front(); e != nil; e = e.Next() {
    inst, _ := e.Value.(Instruction)
    if checkConditional(inst, registers) {
      execute(inst, registers)
      for _, value := range registers {
        if value > max_register_value {
          max_register_value = value
        }
      }
    }
  }
  return registers, max_register_value
}

func checkConditional(i Instruction, registers map[string]int) bool {
  current_value := registers[i.conditional_source]
  switch i.conditional_operator {
  case "==": return current_value == i.conditional_value
  case "!=": return current_value != i.conditional_value
  case ">": return current_value > i.conditional_value
  case "<": return current_value < i.conditional_value
  case ">=": return current_value >= i.conditional_value
  case "<=": return current_value <= i.conditional_value
  default:
    fmt.Println("unknown condition :: ", i)
    return false
  }
}

func execute(i Instruction, registers map[string]int) {
  switch i.operator {
  case "inc":
    registers[i.register] = registers[i.register] + i.value
  case "dec":
    registers[i.register] = registers[i.register] - i.value
  default:
    fmt.Println("unknown operator :: ", i.operator)
  }
}
