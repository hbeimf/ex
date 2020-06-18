# TMP_PATH:=/usr/local/erlang_20.3:/usr/local/erlang_20.3/bin:$(PATH)
TMP_PATH:=/usr/local/erlang_22.3:/usr/local/erlang_22.3/bin:$(PATH)

# erlang:system_info(nif_version).

export PATH=$(TMP_PATH)

run: cp
	./rebar3 shell  --name use_ers@127.0.0.1 --setcookie use_ers_cookie  

cp:
	cp ../ers/target/release/libers.so ./apps/ers/priv/
	
push:
	git add .
	git commit -m 'pu'
	git push
