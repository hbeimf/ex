% ponds_fish_id_actor.erl

% room_id.erl

%% gen_server代码模板

% -module(rid).
-module(id_actor).


-behaviour(gen_server).
% --------------------------------------------------------------------
% Include files
% --------------------------------------------------------------------

% --------------------------------------------------------------------
% External exports
% --------------------------------------------------------------------
-export([pop/1]).

% gen_server callbacks
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SECOND, 1000).

-include_lib("glib/include/log.hrl").
% -record(state, {}).

pop(Num) ->
  gen_server:call(?MODULE, {pop, Num}).

% push(RoomId) ->
%     gen_server:cast(?MODULE, {push, RoomId}).


% --------------------------------------------------------------------
% External API
% --------------------------------------------------------------------
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
% start_link(Params) ->
%     gen_server:start_link(?MODULE, [Params], []).


% --------------------------------------------------------------------
% Function: init/1
% Description: Initiates the server
% Returns: {ok, State}          |
%          {ok, State, Timeout} |
%          ignore               |
%          {stop, Reason}
% --------------------------------------------------------------------
init([]) ->
  % _TRef = erlang:send_after(?SECOND, self(), check_once),
  % ?LOG({Channel_id, RoomType}),
  % Max  = 10,
  % RoomIds = lists:seq(1, Max),

  State = #{fish_id => 1},

  {ok, State}.

% --------------------------------------------------------------------
% Function: handle_call/3
% Description: Handling call messages
% Returns: {reply, Reply, State}          |
%          {reply, Reply, State, Timeout} |
%          {noreply, State}               |
%          {noreply, State, Timeout}      |
%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_call({pop, Num}, _From, #{fish_id := FishId} = State) ->
  % [RoomId|RoomIdList] = lists:seq(Max+1, Max+10),
  % Reply = RoomId,
  % NewState = {RoomIdList, Max+10},

  ReplyFishId = FishId + 1,
  case ReplyFishId >= 65535 of
    true ->
      NewState = #{fish_id => ReplyFishId + Num + 1 - 65535},
      {reply, ReplyFishId - 65535, NewState};
    _ ->
      NewState = #{fish_id => ReplyFishId + Num + 1},
      {reply, ReplyFishId, NewState}
  end;
% handle_call(pop, _From, {[RoomId|RoomIdList], Max} = State) ->
% 	Reply = RoomId,
% 	NewState = {RoomIdList, Max},
% 	{reply, Reply, NewState};
handle_call(Request, _From, State) ->
  ?LOG(Request),
  Reply = ok,
  {reply, Reply, State}.

% --------------------------------------------------------------------
% Function: handle_cast/2
% Description: Handling cast messages
% Returns: {noreply, State}          |
%          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
% handle_cast({push, RoomId}, {RoomIdList, Max} = State) ->
% 	NewState = {[RoomId|RoomIdList], Max},
% 	{noreply, NewState};
handle_cast(_Msg, State) ->
  {noreply, State}.

% --------------------------------------------------------------------
% Function: handle_info/2
% Description: Handling all non call/cast messages
% Returns: {noreply, State}           %          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------

handle_info(stop, State) ->
  {stop, normal, State};
handle_info(_Info, State) ->
  {noreply, State}.

% --------------------------------------------------------------------
% Function: terminate/2
% Description: Shutdown the server
% Returns: any (ignored by gen_server)
% --------------------------------------------------------------------
terminate(_Reason, _State) ->
  ok.

% --------------------------------------------------------------------
% Func: code_change/3
% Purpose: Convert process state when code is changed
% Returns: {ok, NewState}
% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


% private functions
