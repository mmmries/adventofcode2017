package cpu

import "path/filepath"
import "testing"

func TestParsingInstructions(t *testing.T) {
  absPath, _ := filepath.Abs("../../test_input.txt")
  list, err := ParseInstructions(absPath)
  if err != nil {
    t.Errorf("Failed to parse test_input.txt :: %q", err)
  } else {
    if list.Len() != 4 {
      t.Errorf("Parsed the wrong number of instructions from test_input.txt :: %d", list.Len())
    }
    expected := Instruction{"b", "inc", 5, "a", ">", 1}
    if list.Front().Value != expected {
      t.Errorf("Failed to parse first instruction correctly :: %q", list.Front().Value)
    }
    expected = Instruction{"c", "dec", -10, "a", ">=", 1}
    if list.Front().Next().Next().Value != expected {
      t.Errorf("Failed to parse first instruction correctly :: %q", list.Front().Value)
    }
  }
}

func TestRunningInstructions(t *testing.T) {
  absPath, _ := filepath.Abs("../../test_input.txt")
  list, _ := ParseInstructions(absPath)
  registers := RunInstructions(list)
  if registers["a"] != 1 {
    t.Errorf("expected register a == 1, but saw %d", registers["a"])
  }
  if registers["b"] != 0 {
    t.Errorf("expected register b == 0, but saw %d", registers["b"])
  }
  if registers["c"] != -10 {
    t.Errorf("expected register c == -10, but saw %d", registers["c"])
  }
}
