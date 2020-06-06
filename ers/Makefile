
all:
	# export RUSTLER_NIF_VERSION=2.10
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