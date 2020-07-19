package main
 
import "C"

import "github.com/mervick/aes-everywhere/go/aes256"

import "strings"
import "fmt"

func main() {}
 
 //export Echo
func Echo(from string)  *C.char {
	// result := strings.Replace(str_from, str_old, str_new_str, -1)
	// result := "reply"
	fmt.Println("hello world!")
	fmt.Println(from)
	return C.CString("hell")
}

//export StrReplace
func StrReplace(from *C.char, old *C.char, new_str *C.char) *C.char  {
	str_from := C.GoString(from)
	str_old := C.GoString(old)
	str_new_str := C.GoString(new_str)

	// fmt.Println(str_from)
	// fmt.Println(str_old)
	// fmt.Println(str_new_str)

	result := strings.Replace(str_from, str_old, str_new_str, -1)

	// result := "reply"
	return C.CString(result)
}

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