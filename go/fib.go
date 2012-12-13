package main
import "fmt"

func fib(x int) int {
	if x<2 {
		return 1
	} else {
		return fib(x-1) + fib(x-2)
	}
	return 0
}

func main() {
	fmt.Println(fib(45))
}
