# TMP_PATH:=/usr/local/erlang_20.3:/usr/local/erlang_20.3/bin:$(PATH)
TMP_PATH:=/usr/local/erlang_22.3:/usr/local/erlang_22.3/bin:$(PATH)

export PATH=$(TMP_PATH)


all:
	cargo build --release

rel:
	cargo build --release

push:
	git add .
	git commit -m 'pu'
	git push


clean:
	rm -rf ./target
