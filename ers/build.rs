// https://blog.csdn.net/ytxwhwlb/article/details/103465066
// https://blog.arranfrance.com/post/cgo-sqip-rust/


fn main() {
    let path = "/web/ex/go_so/";
    let lib = "add";

    println!("cargo:rustc-link-search=native={}", path);
    println!("cargo:rustc-link-lib=static={}", lib);
}