//use rustler::{ Env, Term, NifResult, Encoder};
use rustler::{Env, Term, Error, Encoder, NifResult};
use rustler::types::list::ListIterator;

#[derive(Debug, NifMap)]
pub struct AMap {
    a: i32,
    b: i32
}

pub fn echo_map<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let r: AMap = args[0].decode()?;

    Ok(r.encode(env))
}

//



pub fn map_list<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let iter: ListIterator = args[0].decode()?;

    let _res: Result<Vec<AMap>, Error> = iter
        .map(|x| x.decode::<AMap>())
        .collect();

//    println!("{:?}", res);

//    match res {
//        Ok(result) => Ok(result.iter().map(|x| x.encode(env)).encode(env)),
//        Err(err) => Err(err),
//    }

//    match res {
//        Ok(result) => Ok(result.iter().fold(0, |acc, &x| acc + x).encode(env)),
//        Err(err) => Err(err),
//    }


    Ok(args[0].encode(env))
}