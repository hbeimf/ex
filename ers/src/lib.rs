#[macro_use] extern crate rustler;
// #[macro_use] extern crate lazy_static;

//extern crate chrono;

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

#[derive(Debug, NifStruct)]
#[module="astruct"]
struct AStruct<'a> {
    a: i64,
    b: f64,
    c: String,
    d: Term<'a>
}

#[derive(Debug, NifStruct)]
#[module="WrappingStruct"]
struct WrappingStruct<'a> {
    a: AStruct<'a>,
    b: i64,
}

#[derive(Debug, NifTuple)]
struct ATuple<'a> {
    a: i64,
    b: f64,
    c: String,
    d: Term<'a>
}

#[derive(Debug, NifTuple)]
struct WrappingTuple<'a> {
    a: ATuple<'a>,
    b: i64
}

#[derive(Debug, NifRecord)]
#[tag = "arecord"]
struct ARecord<'a> {
    a: i64,
    b: f64,
    c: String,
    d: Term<'a>
}

#[derive(Debug, NifRecord)]
#[tag = "wrappingrecord"]
struct WrappingRecord<'a> {
    a: ARecord<'a>,
    b: i64
}

#[derive(Debug, NifMap)]
pub struct AMap {
    a: i32,
    b: i32
}

rustler_export_nifs! {
    "ers",
    [
        ("add", 2, add),
        ("current_time", 0, current_time),
        ("hello", 1, hello),
        ("echo_struct", 1, echo_struct),
        ("echo_wrapping_struct", 1, echo_wrapping_struct),
        ("echo_tuple", 1, echo_tuple),
        ("echo_wrapping_tuple", 1, echo_wrapping_tuple),
        ("echo_record", 1, echo_record),
        ("echo_wrapping_record", 1, echo_wrapping_record),
        ("echo_term", 1, echo_term),
        ("echo_map", 1, echo_map),
    ],
    None
}

fn echo_map<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: AMap = args[0].decode()?;

    Ok(r.encode(env))
}


fn echo_record<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: ARecord = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_wrapping_record<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: WrappingRecord = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_term<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    Ok(args[0].encode(env))
}

fn echo_wrapping_tuple<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: WrappingTuple = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_tuple<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: ATuple = args[0].decode()?;

    Ok(r.encode(env))
}

//https://github.com/evnu/rusty/blob/master/native/rusty/src/lib.rs
fn echo_struct<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let s: AStruct = args[0].decode()?;

    Ok(s.encode(env))
}

fn echo_wrapping_struct<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let s: WrappingStruct = args[0].decode()?;

    Ok(s.encode(env))
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
