
all:
	export RUSTLER_NIF_VERSION=2.10
	cargo build --release

rel:
	cargo build --release

push:
	git add .
	git commit -m 'pu'
	git push


clean:
	rm -rf ./Cargo.lock
	rm -rf ./target


# erlang:system_info(nif_version).
# RUSTLER_NIF_VERSION=2.7 mix compile
# use std::env;
# let version = env::var("RUSTLER_NIF_VERSION")	

# 切换回过去的某个指定版本
# rustup default xxxxx



# wget https://static.rust-lang.org/rustup/rustup-init.sh
# sh rustup-init.sh
# source $HOME/.cargo/env
# rustc --version

# rustup default 1.20.0

