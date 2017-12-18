package defrag

import "encoding/hex"
import "knot"
import "math/bits"
import "strconv"

func CountOccupiedBits(grid [128][16]byte) int {
  count := 0
  for i:=0; i < 128; i++ {
    for j:=0; j<16; j++ {
      count += bits.OnesCount8(grid[i][j])
    }
  }
  return count
}

func HashToBytes(str string) []byte {
  bytes, _ := hex.DecodeString(str)
  return bytes
}

func SeedToGrid(seed string) [128][16]byte {
  var grid [128][16]byte
  for i:=0; i < 128; i++ {
    row_seed := seed + "-" + strconv.Itoa(i)
    hash := knot.Hash(row_seed)
    bytes := HashToBytes(hash)
    for j:=0; j<16; j++ {
      grid[i][j] = bytes[j]
    }
  }

  return grid
}
