#[macro_use] extern crate rustler;
// #[macro_use] extern crate lazy_static;

extern crate chrono;

use chrono::{DateTime, Utc};

use rustler::{Binary, Env, Term, NifResult, Encoder};
// use rustler::{Binary, Encoder, Env, NifResult, OwnedBinary, Term};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "ers",
    [
        ("add", 2, add),
        ("current_time", 0, current_time),
        ("hello", 1, hello),
    ],
    None
}

fn hello<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
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

fn add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let num1: i64 = args[0].decode()?;
    let num2: i64 = args[1].decode()?;

    Ok((atoms::ok(), num1 + num2).encode(env))
}

fn current_time<'a>(env: Env<'a>, _args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let now: DateTime<Utc> = Utc::now();

    let timestamp: i64 = now.timestamp();
    let nanosec: u32 = now.timestamp_subsec_nanos();

    Ok((timestamp*1000000000 + nanosec as i64).encode(env))
}
