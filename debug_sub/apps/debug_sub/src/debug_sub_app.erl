%%%-------------------------------------------------------------------
%% @doc debug_sub public API
%% @end
%%%-------------------------------------------------------------------

-module(debug_sub_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    debug_sub_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
