use rustler::{ Env, Term, NifResult, Encoder};


#[derive(Debug, NifMap)]
pub struct AMap {
    a: i32,
    b: i32
}

pub fn echo_map<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: AMap = args[0].decode()?;

    Ok(r.encode(env))
}