use rustler::{ Env, Term, NifResult, Encoder};

pub fn echo_term<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    Ok(args[0].encode(env))
}
