use rustler::{ Env, Term, NifResult, Encoder};

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



//https://github.com/evnu/rusty/blob/master/native/rusty/src/lib.rs
pub fn echo_struct<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let s: AStruct = args[0].decode()?;

    Ok(s.encode(env))
}

pub fn echo_wrapping_struct<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let s: WrappingStruct = args[0].decode()?;

    Ok(s.encode(env))
}