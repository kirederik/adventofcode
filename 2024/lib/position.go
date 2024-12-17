package lib

type Position struct {
	X, Y int
}

func FindPosition[E comparable](grid [][]E, target E) *Position {
	for i := range grid {
		for j := range grid[i] {
			if grid[i][j] == target {
				return &Position{i, j}
			}
		}
	}
	return nil
}

func (p *Position) Add(p2 *Position) *Position {
	return &Position{
		X: p.X + p2.X,
		Y: p.Y + p2.Y,
	}
}
func (p *Position) AddPos(x, y int) *Position {
	return &Position{
		X: p.X + x,
		Y: p.Y + y,
	}
}

func (p *Position) Equal(p2 *Position) bool {
	return p.X == p2.X && p.Y == p2.Y
}

func (p *Position) Mul(val int) *Position {
	return &Position{X: p.X * val, Y: p.Y * val}
}
