package main
 
import "C"
 
func main() {}
 


//export Add
func Add(a int32, b int32) int32 {
    return a + b 
}
 
// go build -x -v -ldflags "-s -w" -buildmode=c-shared -o libhello.so   main.go