lib:
	go build -x -v -ldflags "-s -w" -buildmode=c-shared -o libadd.so   main.go

clean:
	rm -rf ./libhello.so
	rm -rf ./libhello.h
	rm -rf ./libadd.so
	rm -rf ./libadd.h


# https://www.cnblogs.com/coolyylu/p/7008074.html