%%%-------------------------------------------------------------------
%% @doc pub public API
%% @end
%%%-------------------------------------------------------------------

-module(pub_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    pub_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
