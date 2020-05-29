use rustler::{ Env, Term, NifResult, Encoder};
use lib;

use crate::atoms;

use std::ffi::CString;
use std::os::raw::c_char;
use std::ffi::CStr;


pub fn add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let num1: i32 = args[0].decode()?;
    let num2: i32 = args[1].decode()?;

    let res = call_dynamic_add(num1, num2);
    match res {
        Ok(result) => {
            Ok((atoms::ok(), result).encode(env))

        },
        Err(err) => {
            Ok((atoms::error(), err.to_string()).encode(env))
        },

    }

//    Ok((atoms::ok(), num1 + num2).encode(env))
}

fn call_dynamic_add(a:i32, b:i32) -> Result<i32, Box<dyn std::error::Error>> {
    let lib = lib::Library::new("/web/ex/c_so/libadd.so")?;
    unsafe {
        let func: lib::Symbol<unsafe extern fn(i32, i32) -> i32> = lib.get(b"add")?;
        Ok(func(a, b))
    }

}

//调用clang时传字符串
//https://doc.rust-lang.org/std/ffi/struct.CString.html#examples-3


fn call_dynamic_str_replace(from_str:String, old:String, new: String) -> Result<*mut c_char, Box<dyn std::error::Error>> {
    let lib = lib::Library::new("/web/ex/c_so/libadd.so")?;
    unsafe {
        let c_string_1 = CString::new(from_str).expect("CString::new failed");
        let s1 = c_string_1.into_raw();

        let c_string_2 = CString::new(old).expect("CString::new failed");
        let s2 = c_string_2.into_raw();

        let c_string_3 = CString::new(new).expect("CString::new failed");
        let s3 = c_string_3.into_raw();


        let func: lib::Symbol<unsafe extern fn(s1: *mut c_char, s2: *mut c_char, s3: *mut c_char) -> *mut c_char> = lib.get(b"str_replace")?;
        Ok(func(s1, s2, s3))
    }

}



#[derive(Debug, NifTuple)]
struct StrReplace {
    from_str: String,
    old: String,
    new: String,
}

//impl StrReplace{
//    fn replace(&mut self) -> String {
//        return self.from_str.as_mut_str().replace(&self.old, &self.new);
//    }
//}

pub fn clang_str_replace<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let  r: StrReplace = args[0].decode()?;
//    let new_str = r.replace();

    let res = call_dynamic_str_replace(r.from_str, r.old, r.new);
    match res {
        Ok(result) => {
//            Ok((atoms::ok(), result).encode(env))
//            println!("res:{:?}", result);
            let new_str = unsafe {
                let c_str: &CStr = CStr::from_ptr(result);
                let str_slice: &str = c_str.to_str().unwrap();
                let str_buf: String = str_slice.to_owned();
//                println!("res1: {:?}", str_buf);
                str_buf
            };
//            println!()
            Ok((atoms::ok(), new_str).encode(env))

        },
        Err(err) => {
            Ok((atoms::error(), err.to_string()).encode(env))
//            println!("err:{:?}", err);
        },


    }

//    Ok((atoms::ok(), new_str.to_string()).encode(env))
}



