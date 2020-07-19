%%%-------------------------------------------------------------------
%% @doc erl_use_obj public API
%% @end
%%%-------------------------------------------------------------------

-module(erl_use_obj_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    erl_use_obj_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
