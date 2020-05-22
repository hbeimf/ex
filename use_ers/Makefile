run: cp
	./rebar3 shell  --name use_ers@127.0.0.1 --setcookie use_ers_cookie  

cp:
	cp ../ers/target/release/libers.so ./apps/ers/priv/
	
push:
	git add .
	git commit -m 'pu'
	git push
