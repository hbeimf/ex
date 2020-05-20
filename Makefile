all:
	cargo build

rel:
	cargo build --release

push:
	git add .
	git commit -m 'pu'
	git push


