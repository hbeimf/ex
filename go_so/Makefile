GOPATH := $(shell pwd)


# 生成动态库
all:
	@GOPATH=$(GOPATH) go get -d
	@GOPATH=$(GOPATH) go build -x -v -ldflags "-s -w" -buildmode=c-shared -o libadd.so   main.go

lib:
	go build -x -v -ldflags "-s -w" -buildmode=c-shared -o libadd.so   main.go

clean:
	rm -rf ./libhello.so
	rm -rf ./libhello.h
	rm -rf ./libadd.so
	rm -rf ./libadd.h

# 生成静态库
slib:
	@GOPATH=$(GOPATH) go get -d
	@GOPATH=$(GOPATH) go build -buildmode=c-archive -o libadd.a main.go


# https://www.cnblogs.com/coolyylu/p/7008074.html