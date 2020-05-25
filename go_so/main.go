package main
 
import "C"

import "github.com/mervick/aes-everywhere/go/aes256"



func main() {}
 


//export Add
func Add(a int32, b int32) int32 {
	return a + b 
}

//export Encode
func Encode(con string, password string) string {
	// encryption
	encrypted := aes256.Encrypt(con, password)
	return encrypted
}

//export Decode
func Decode(con string, password string) string {
	// decryption
	decrypted := aes256.Decrypt(con, password)
	return decrypted
}

 
// go build -x -v -ldflags "-s -w" -buildmode=c-shared -o libhello.so   main.go