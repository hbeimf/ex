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

//tt:map_list().
pub fn map_list<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let iter: ListIterator = args[0].decode()?;

    let res: Result<Vec<AMap>, Error> = iter
        .map(|x| x.decode::<AMap>())
        .collect();

    match res {
        Ok(result) => {
            for elem in result.iter() {
                println!("map:{:?}", elem);
            }

        },
        Err(_err) => {
//            Err(err)
            ()
        },
    };


    let m1 = AMap{a: 10, b: 11};
    let m2 = AMap{a: 20, b: 21};
    let list = vec![m1, m2];

//    Ok(args[0].encode(env))
//    let list = vec![1, 2, 3];
    Ok(list.encode(env))


}