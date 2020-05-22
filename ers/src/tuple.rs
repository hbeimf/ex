use rustler::{ Env, Term, NifResult, Encoder};

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


pub fn echo_wrapping_tuple<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: WrappingTuple = args[0].decode()?;

    Ok(r.encode(env))
}

pub fn echo_tuple<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: ATuple = args[0].decode()?;

    Ok(r.encode(env))
}