-module(tt).
-compile(export_all).

-include_lib("ers/include/log.hrl").


-record(arecord, {
	a, 
	b,
	c,
	d
}).

-record(wrappingrecord, {
	a, 
	b
}).


% tt:echo_record().
echo_record() ->
	ers:echo_record(#arecord{a=80, b=1.1, c = <<"hello">>, d=self()} ).

% tt:echo_wrapping_record().
echo_wrapping_record() ->
	A = #arecord{a=80, b=1.1, c = <<"hello">>, d=self()},
	WrappingRecord = #wrappingrecord{a= A, b=100},
	ers:echo_wrapping_record(WrappingRecord).	