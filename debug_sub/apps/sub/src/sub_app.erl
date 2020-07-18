%%%-------------------------------------------------------------------
%% @doc sub public API
%% @end
%%%-------------------------------------------------------------------

-module(sub_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    sub_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
