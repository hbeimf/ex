#[macro_use] extern crate rustler;
// #[macro_use] extern crate lazy_static;

//extern crate chrono;
//
//use chrono::{DateTime, Utc};
//
use rustler::{Term};
// use rustler::{Binary, Encoder, Env, NifResult, OwnedBinary, Term};

extern crate libloading as lib;


mod tuple;
mod map;
mod record;
mod term;
mod ex_struct;
mod fun;
mod list;
mod atoms;
mod api_string;
mod api_clang_dll;
mod api_golang_dll;


pub mod chapter1;

rustler_export_nifs! {
    "ers",
    [
        ("add", 2, fun::add),
        ("current_time", 0, fun::current_time),
        ("hello", 1, fun::hello),
        ("echo_struct", 1, ex_struct::echo_struct),
        ("echo_wrapping_struct", 1, ex_struct::echo_wrapping_struct),
        ("echo_tuple", 1, tuple::echo_tuple),
        ("echo_wrapping_tuple", 1, tuple::echo_wrapping_tuple),
        ("echo_record", 1, record::echo_record),
        ("echo_wrapping_record", 1, record::echo_wrapping_record),
        ("echo_term", 1, term::echo_term),
        ("echo_map", 1, map::echo_map),
        ("map_list", 1, map::map_list),
        ("sum_list", 1, list::sum_list),
        ("make_list", 0, list::make_list),
        ("test", 1, api_string::test),
        ("str_replace", 1, api_string::str_replace),
        ("clang_add", 2, api_clang_dll::add),
        ("clang_str_replace", 1, api_clang_dll::clang_str_replace),
        ("golang_add", 2, api_golang_dll::add),
        ("golang_str_replace", 1, api_golang_dll::golang_str_replace),
    ],
    None
}


