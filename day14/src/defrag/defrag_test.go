package defrag

import "testing"

func TestConvertHexToBits(t *testing.T) {
  hash := "a0c201"
  bytes := HashToBytes(hash)
  if bytes[0] != 160 {
    t.Errorf("expected first byte to be 160")
  }
}

func TestBuildGridFromSeed(t *testing.T) {
  seed := "flqrgnkx"
  grid := SeedToGrid(seed)
  if len(grid) != 128 {
    t.Errorf("expected grid to have 128 rows")
  }
  if len(grid[0]) != 16 {
    t.Errorf("exepcted first row to have 16 bytes")
  }
  if grid[0][0] != 212 {
    t.Errorf("expected first byte to be 212")
  }
}

func TestCountingOccupiedBits(t *testing.T) {
  seed := "flqrgnkx"
  grid := SeedToGrid(seed)
  count := CountOccupiedBits(grid)
  if count != 8108 {
    t.Errorf("expected to have 8108 occupied bits")
  }
}
