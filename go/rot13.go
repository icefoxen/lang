package main

import (
	"fmt"
	"io"
	"os"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}

func (r rot13Reader) Read(p []byte) (int, error) {
	count, err := r.r.Read(p)
	for i := 0; i < count; i++ {
		//c := p[i]
		
		p[i] -= 13
	}
	fmt.Println(len(p))
	//for _, c := range p {
	//	fmt.Println(c)
	//}
	return count, err
}

func main() {
	s := strings.NewReader(
		"Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}
