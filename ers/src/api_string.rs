//use chrono::{DateTime, Utc};

use rustler::{Binary, Env, Term, NifResult, Encoder};
//use lib;

use crate::atoms;

//use std::env;

#[derive(Debug, NifTuple)]
struct StrReplace {
    from_str: String,
    old: String,
    new: String,
}

impl StrReplace{
    fn replace(&mut self) -> String {
        return self.from_str.as_mut_str().replace(&self.old, &self.new);
    }
}

pub fn str_replace<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let mut  r: StrReplace = args[0].decode()?;
    let new_str = r.replace();
    Ok((atoms::ok(), new_str.to_string()).encode(env))
}



pub fn test<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
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

