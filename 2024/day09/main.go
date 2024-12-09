package day09

import (
	"fmt"
	"slices"
	"strconv"

	"github.com/kirederik/adventofcode/2024/lib"
)

func Puzzle01(inputPath string) int64 {
	compacted := lib.Read(inputPath)[0]
	var space bool
	var id int

	var expanded []int

	for i := 0; i < len(compacted); i++ {
		n, _ := strconv.Atoi(string(compacted[i]))
		block := make([]int, n)
		for j := range block {
			if space {
				block[j] = -1
			} else {
				block[j] = id
			}
		}
		expanded = append(expanded, block...)

		if !space {
			id++
		}
		space = !space
	}

	left := 0
	right := len(expanded) - 1

	for left < right {
		if expanded[left] > -1 {
			left++
			continue
		}

		if expanded[right] == -1 {
			right--
			continue
		}

		expanded[left], expanded[right] = expanded[right], expanded[left]
	}

	return checksum(expanded)
}

type Block struct {
	id   int
	size int
}

func Puzzle02(inputPath string) int64 {
	compacted := lib.Read(inputPath)[0]
	var space bool
	var id int

	var blocks []Block

	for i := 0; i < len(compacted); i++ {
		n, _ := strconv.Atoi(string(compacted[i]))
		blockID := id
		if space {
			blockID = -1
		}
		blocks = append(blocks, Block{id: blockID, size: n})

		if !space {
			id++
		}
		space = !space
	}

	left := 0
	right := len(blocks) - 1

	for left < right {
		if blocks[left].id > -1 {
			left++
			continue
		}
		if blocks[right].id == -1 {
			right--
			continue
		}

		for i := left; i < right; i++ {
			if blocks[i].id != -1 {
				continue
			}

			if blocks[i].size >= blocks[right].size {
				emptySize := blocks[i].size
				blockSize := blocks[right].size

				newBlock := Block{id: blocks[right].id, size: blockSize}
				newEmptyBlock := Block{id: -1, size: blockSize}
				emptyBlock := Block{id: -1, size: emptySize - blockSize}

				blocks[i] = newBlock
				blocks[right] = newEmptyBlock

				if emptyBlock.size > 0 {
					blocks = slices.Insert(blocks, i+1, emptyBlock)
				}

				break
			}
		}

		right--
	}

	return checksumBlocks(blocks)
}

func checksumBlocks(blocks []Block) int64 {
	var sum int64
	var index int
	for _, b := range blocks {
		if b.id == -1 {
			index += b.size
			continue
		}
		for i := 0; i < b.size; i++ {
			sum += int64(index * b.id)
			index++
		}
	}
	return sum
}

func checksum(disk []int) int64 {
	var sum int64
	for i, v := range disk {
		if v == -1 {
			break
		}

		sum += int64(i * v)
	}

	return sum
}

func printBlocks(blocks []Block) {
	for _, b := range blocks {
		for i := 0; i < b.size; i++ {
			if b.id == -1 {
				fmt.Print(".")
			} else {
				fmt.Print(b.id, ":")
			}
		}
	}
	fmt.Println()
}

func printDisk(expanded []int) {
	for _, b := range expanded {
		if b == -1 {
			fmt.Print(".")
		} else {
			fmt.Print(b)
		}
	}
	fmt.Println()
}
