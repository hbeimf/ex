% pub.erl

-module(pub).
-compile(export_all).
-include_lib("glib/include/log.hrl").



pub() -> 
	pub_actor:send().


