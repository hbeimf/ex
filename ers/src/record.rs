use rustler::{ Env, Term, NifResult, Encoder};


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

pub fn echo_record<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: ARecord = args[0].decode()?;

    Ok(r.encode(env))
}

pub fn echo_wrapping_record<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: WrappingRecord = args[0].decode()?;

    Ok(r.encode(env))
}