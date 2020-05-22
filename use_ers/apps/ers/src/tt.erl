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

for() -> 
	for(1000).


for(Times) ->
	lists:foreach(fun(Id) -> 
		% ?LOG({index, Id}),
		test(Id)
	end, lists:seq(1, Times)).

test(Id) -> 
	R1 = ers:echo_term(hello_world),
	R2 = ers:echo_map(#{a => 1, b => 3}),

	R3 = echo_record(),
	R4 = echo_wrapping_record(),

	R5 = ers:echo_wrapping_tuple({{10, 1.0, <<"hello">>, self()}, 20}),
	R6 = ers:echo_tuple({10, 1.0, <<"hello">>, self()}),
	?LOG(#{index => Id, r1 =>R1, r2 =>R2, r3=>R3, r4=>R4, r5=>R5, r6=>R6}),
	ok.

map_list() ->
	ers:map_list([#{a => 1, b => 3}, #{a => 1, b => 8}]).


% tt:echo_record().
echo_record() ->
	ers:echo_record(#arecord{a=80, b=1.1, c = <<"hello">>, d=self()} ).

% tt:echo_wrapping_record().
echo_wrapping_record() ->
	A = #arecord{a=80, b=1.1, c = <<"hello">>, d=self()},
	WrappingRecord = #wrappingrecord{a= A, b=100},
	ers:echo_wrapping_record(WrappingRecord).	