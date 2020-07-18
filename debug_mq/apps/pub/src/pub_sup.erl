%%%-------------------------------------------------------------------
%% @doc pub top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(pub_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    % SupFlags = #{strategy => one_for_all,
    %              intensity => 0,
    %              period => 1},
    % ChildSpecs = [],
    % {ok, {SupFlags, ChildSpecs}}.

%% internal functions
    Children = [
    	child(pub_actor)
    	% , child(rabbit_error_log_send)
     %    , child(rabbit_pub_account_log)
     %    , child(rabbit_pub_game_log)
     %    , child(pub_cache)
     %    , child(rabbit_pub_channel_credits_log)
     %    , child(rabbit_pub_modify_account_interface)
    ],

    {ok, { {one_for_one, 10, 10}, Children} }.


%%====================================================================
%% Internal functions
%%====================================================================
child(Mod) ->
	Child = {Mod, {Mod, start_link, []},
               permanent, 5000, worker, [Mod]},
               Child.
