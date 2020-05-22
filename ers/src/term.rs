use rustler::{ Env, Term, NifResult, Encoder};

//ers:echo_term([1,2,3]).
pub fn echo_term<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    println!("term: {:?}", args[0]);
    Ok(args[0].encode(env))
}
