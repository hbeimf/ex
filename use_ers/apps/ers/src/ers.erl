-module(ers).
% -compile(export_all).

-include_lib("ers/include/log.hrl").



% test() -> 
% 	ok.

% -module(rust_nif).

%% API Exports
-export([
	hello/1,
	 add/2,
	 current_time/0,
	 echo_struct/1,
	 echo_wrapping_struct/1,
	 echo_tuple/1,
	 echo_wrapping_tuple/1,
	 echo_record/1,
	 echo_wrapping_record/1,
	 echo_term/1,
	 echo_map/1,
	 map_list/1,
	 sum_list/1,
	 make_list/0,
	 clang_add/2,
	 clang_str_replace/1,
	 golang_add/2,
	 golang_str_replace/1
	]).

-export([
	str_replace/1,
	test/1

	]).

-on_load(init/0).

-define(APPNAME, ?MODULE).
-define(LIBNAME, "libers").


% ers:golang_str_replace({<<"hello world">>, <<"world">>, <<"you">>}).
golang_str_replace(_) -> 
	not_loaded(?LINE).
% ers:golang_add(1,2).
golang_add(_,_) ->
    not_loaded(?LINE).

% ers:clang_str_replace({<<"hello world">>, <<"world">>, <<"you">>}).
% {ok, S} = ers:clang_str_replace({<<"hello world">>, <<"world">>, unicode:characters_to_binary("你好")}).
% io:format("~ts~n", [S]).

clang_str_replace(_) -> 
	not_loaded(?LINE).
% ers:clang_add(1,2).
clang_add(_,_) ->
    not_loaded(?LINE).
% ers:str_replace({<<"hello world">>, <<"world">>, <<"you">>}).
% {ok, S} = ers:str_replace({<<"hello world">>, <<"world">>, unicode:characters_to_binary("你好")}).
% io:format("~ts~n", [S]).
str_replace(_) ->
	not_loaded(?LINE).

test(_) ->
	not_loaded(?LINE).
%%====================================================================
%% API functions - NIFS
%%====================================================================

% %% @doc add/2 adds two integers and returns their sum
% %%
% %% @end
% -spec add(A, B) -> {ok, Sum}
% 	when
% 	A :: integer(),
% 	B :: integer(),
% 	Sum :: integer().
% add(A,B) ->
% 	add_nif(A,B).

%%====================================================================
%% NIFS
%%====================================================================
% ers:echo_map(#{a => 1, b => 3}).
echo_map(_) ->
	not_loaded(?LINE).

map_list(_) -> 
	not_loaded(?LINE).

% ers:echo_record({{10, 1.0, <<"hello">>, self()}, 20}).
echo_record(_) ->
	not_loaded(?LINE).

echo_wrapping_record(_) ->
	not_loaded(?LINE).

echo_term(_) ->
	not_loaded(?LINE).

% ers:echo_wrapping_tuple({{10, 1.0, <<"hello">>, self()}, 20}).
echo_wrapping_tuple(_) ->
	not_loaded(?LINE).

% ers:echo_tuple({10, 1.0, <<"hello">>, self()}).
echo_tuple(_) ->
	not_loaded(?LINE).

% ers:echo_struct(#{a=>10, b=>1.1, c => "hello", d=>self()}).
% ers:echo_struct([{a, 10}, {b, 1.1}, {c, "hello"}, {d, self()}]).
% #server_opts{port=80}. 
% ers:echo_struct(#ers{a=80, b=1.1, c="hello", d=self()} ).
% ???????????????????????????????????????????
% erlang里没有对应 的struct结果
% iex(node4@127.0.0.1)3> s = %GameServer.AStruct{}
% %GameServer.AStruct{a: 10, b: 1.0, c: "hello", d: #PID<0.219.0>}
echo_struct(_) ->
	not_loaded(?LINE).

echo_wrapping_struct(_) ->
	not_loaded(?LINE).

hello(_) ->
	not_loaded(?LINE).
	
add(_,_) ->
    not_loaded(?LINE).

current_time() ->
    not_loaded(?LINE).

sum_list(_) ->
    not_loaded(?LINE).

make_list() ->
    not_loaded(?LINE).
%%====================================================================
%%%% Internal functions
%%%%%====================================================================
init() ->
	?LOG("ers load init"),
    SoName = case code:priv_dir(?APPNAME) of
       {error, bad_name} ->
          case filelib:is_dir(filename:join(["..", priv])) of
            true ->
              filename:join(["..", priv, ?LIBNAME]);
            _ ->
              filename:join([priv, ?LIBNAME])
          end;
       Dir ->
          filename:join(Dir, ?LIBNAME)
    end,
    erlang:load_nif(SoName, 0).

not_loaded(Line) ->
	    exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).
