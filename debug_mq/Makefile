run: 
	# rm config.ini
	# cp ./config.hub1.ini ./config.ini
	./rebar3 shell --name debug_pub@127.0.0.1 --setcookie debug_pub_cookie

run2:
	rm config.ini
	cp ./config.hub2.ini ./config.ini
	./rebar3 shell --name run2@127.0.0.1 --setcookie node1_cookie


run3:
	./rebar3 shell --name run3@127.0.0.1 --setcookie node1_cookie


stop:
	ps -efww|grep xgn.node|grep -v grep|cut -c 9-15|xargs kill -9

push:
	git add .
	git commit -m 'pu'
	git push

ps:
	ps aux | grep xgn.node

rel: 
	./rebar3 compile
	./rebar3 release
	./rebar3 tar

cc:
	rm -rf  ./Mnesia.*

# # # GOPATH := $(shell pwd)
# # ERL_HOME := /usr/local/erlang_18.3
# # ERL_BIN := /usr/local/erlang_18.3/bin

# all:
# 	@GOPATH=$(GOPATH) go get -d
# 	@GOPATH=$(GOPATH) go run ./demoGenServer.go


# export "/usr/local/erlang_18.3"
	# export "/usr/local/erlang_18.3/bin"
	# source /etc/profile

v18:
	make ERL_HOME=/usr/local/erlang_18.3:/usr/local/erlang_18.3/bin
	erl
