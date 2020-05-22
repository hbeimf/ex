use chrono::{DateTime, Utc};

use rustler::{Binary, Env, Term, NifResult, Encoder};
use lib;

use crate::atoms;

pub fn hello<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    // let resource: ResourceArc<FilterResource> = args[0].decode()?;
    let _person: Binary = if args[0].is_binary() {
        args[0].decode()?
    } else {
        Binary::from_owned(args[0].to_binary(), env)
    };

    // println!("{:b}", person);
    // let mut filter = resource.filter.write().unwrap();
    // (*filter).set(&key);

    Ok(atoms::ok().encode(env))
}

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

pub fn current_time<'a>(env: Env<'a>, _args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let now: DateTime<Utc> = Utc::now();

    let timestamp: i64 = now.timestamp();
    let nanosec: u32 = now.timestamp_subsec_nanos();


    Ok((timestamp*1000000000 + nanosec as i64).encode(env))
}


fn call_dynamic_add(a:i32, b:i32) -> Result<i32, Box<dyn std::error::Error>> {
//    let lib = lib::Library::new("/web/ex/c_so/libadd.so")?;
//    unsafe {
//        let func: lib::Symbol<unsafe extern fn(i32, i32) -> i32> = lib.get(b"add")?;
//        Ok(func(a, b))
//    }

    let lib = lib::Library::new("/web/ex/go_so/libadd.so")?;
    unsafe {
        let func: lib::Symbol<unsafe extern fn(i32, i32) -> i32> = lib.get(b"Add")?;
        Ok(func(a, b))
    }
}

