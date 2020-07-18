% sub_actor.erl

% rabbit_sub_user_game_record.erl
%% gen_server代码模板

-module(sub_actor).

-behaviour(gen_server).
% --------------------------------------------------------------------
% Include files
% --------------------------------------------------------------------

% --------------------------------------------------------------------
% External exports
% --------------------------------------------------------------------
-export([]).

% gen_server callbacks
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -define(TIMER, 2000).
-define(TIMER, 10000).

-record(state, { 
	channel
	, conn
    }).

-include_lib("amqp_client/include/amqp_client.hrl").
-include_lib("glib/include/log.hrl").


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% --------------------------------------------------------------------
% Function: init/1
% Description: Initiates the server
% Returns: {ok, State}          |
%          {ok, State, Timeout} |
%          ignore               |
%          {stop, Reason}
% --------------------------------------------------------------------
init([]) ->
	erlang:send_after(?TIMER, self(), maybe_connect),
	process_flag(trap_exit, true),
	% Channel = 
	case maybe_connect() of 
		{ok, Channel, Connection} ->  
			State = #state{channel = Channel, conn = Connection},
			{ok,  State};
		_ -> 
			State = #state{channel = conn_fail, conn = conn_fail},
			{ok,  State}
	end.

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
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

% --------------------------------------------------------------------
% Function: handle_cast/2
% Description: Handling cast messages
% Returns: {noreply, State}          |
%          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_cast(_Msg, State) ->
    {noreply, State}.

% --------------------------------------------------------------------
% Function: handle_info/2
% Description: Handling all non call/cast messages
% Returns: {noreply, State}           %          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_info(maybe_connect, State = #state{channel = Channel, conn = Connection}) ->
    	_TRef = erlang:send_after(?TIMER, self(), maybe_connect),
  %   	amqp_channel:close(Channel),
		% amqp_connection:close(Connection),

    	case erlang:is_pid(Channel) andalso glib:is_pid_alive(Channel) 
    		andalso erlang:is_pid(Connection) andalso glib:is_pid_alive(Connection) of 
    		true ->
    			Info = amqp_connection:info(Connection, [is_closing]),
			    % ?LOG(Info),
			    case Info of 
			    	[{is_closing,false}|_] ->
			    		% ?LOG(Info),
    					% {noreply, State};
    					R = amqp_connection:info(Connection, [num_channels]),
    					% ?LOG(R),
    					case R of 
			    			[{num_channels,1}|_] ->
				    			% ?LOG(Info),
	    						{noreply, State};
	    					_ -> 
	    						glib:write_req({?MODULE, ?LINE, {Channel, Connection}}, "subUserGameRecord-reconnect"),
		    					% ?LOG(Info),
		    					amqp_channel:close(Channel),
				    			amqp_connection:close(Connection),

				    			case maybe_connect() of 
									{ok, Channel1, Connection1} ->  
										State1 = #state{channel = Channel1, conn = Connection1},
										{noreply,  State1};
									_ -> 
										{noreply, State}
								end
						end;	
    				_ -> 
    					glib:write_req({?MODULE, ?LINE, {Channel, Connection}}, "subUserGameRecord-reconnect"),
    					% ?LOG(Info),
    					amqp_channel:close(Channel),
		    			amqp_connection:close(Connection),

		    			case maybe_connect() of 
							{ok, Channel1, Connection1} ->  
								State1 = #state{channel = Channel1, conn = Connection1},
								{noreply,  State1};
							_ -> 
								{noreply, State}
						end
				end;

    		_ -> 
    			glib:write_req({?MODULE, ?LINE, {Channel, Connection}}, "subUserGameRecord-reconnect"),
    					
    			amqp_channel:close(Channel),
    			amqp_connection:close(Connection),

    			case maybe_connect() of 
					{ok, Channel1, Connection1} ->  
						State1 = #state{channel = Channel1, conn = Connection1},
						{noreply,  State1};
					_ -> 
						{noreply, State}
				end
    	end;
          % {noreply, State};
handle_info( {#'basic.deliver'{delivery_tag = DeliveryTag}, #amqp_msg{payload = Body}}, State = #state{channel = Channel}) ->
	% LogFile = sys_log:log_file("ack_game_record"),
	% sys_log:append(LogFile, Body),

	amqp_channel:call(Channel, #'basic.ack'{delivery_tag = DeliveryTag}),
	?LOG(#{msg => Body, channel => Channel}),
	% work_user_game_record:send_msg(Body),

	% RandId = glib:uid(),
	% glib:write_req({?MODULE, ?LINE, RandId, Body}, "subUserGameRecord"),
	% % Json = binary_to_term(Body),
	% Json = Body,
	% Data = jsx:decode(Json),
	% glib:write_req({?MODULE, ?LINE,RandId, Data}, "subUserGameRecord"),
	
	% lists:foreach(fun(Row) -> 
	% 	GameId = glib:get_by_key(<<"game_id">>, Row),
	% 	% ?LOG({GameId, Row}),
	% 	user_game_record_sync:send_async(GameId, Row),
	% 	ok
	% end, Data),

	% amqp_channel:cast(Channel, #'basic.ack'{delivery_tag = DeliveryTag}),
	{noreply, State};
handle_info(Info, State) ->
	glib:write_req({?MODULE, ?LINE, Info}, "subUserGameRecord-other-msg"),
	?LOG(Info),
	{noreply, State}.

% handle_info(Info, State) ->
%     % 接收来自go 发过来的异步消息
%     io:format("~nhandle info BBB!!============== ~n~p~n", [Info]),
%     {noreply, State}.

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


% priv ======================================
queue_name() ->
	<<"data.game_record_log">>.

exchange() -> 
	<<"game_record_log">>.

type() ->
    <<"direct">>.

maybe_connect() ->
	{Host1, UserName1, Password1, VirtualHost1, Port1} = case  sys_config:get_config(rabbitmq) of
	        {ok, Config} -> 
	            {_, {host, Host}, _} = lists:keytake(host, 1, Config),
	            {_, {port, Port}, _} = lists:keytake(port, 1, Config),
	            {_, {username, UserName}, _} = lists:keytake(username, 1, Config),
	            {_, {password, Password}, _} = lists:keytake(password, 1, Config),
	            {_, {virtual_host, VirtualHost}, _} = lists:keytake(virtual_host, 1, Config),

	            {glib:to_str(Host)
	            ,glib:to_binary(UserName)
	            , glib:to_binary(Password)
	            , glib:to_binary(VirtualHost)
	            ,glib:to_integer(Port)};  
	        _ -> 
	            {"localhost", <<"admin">>, <<"admin">>, <<"/">>, 5672}
	end,

	
	case amqp_connection:start(#amqp_params_network{
		virtual_host = VirtualHost1,
		host = Host1,
		port = Port1,
		username           = UserName1,
	      	password           = Password1
	}) of 
		{ok, Connection} -> 
			?LOG(#{connection_pid => Connection, pos => 0, gap => "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"}),

			% {ok, Channel} = amqp_connection:open_channel(Connection),

			% 	?LOG(conn_game_record), 
			% 	amqp_channel:call(Channel, #'exchange.declare'{exchange = exchange(),
			%                                                    type = <<"direct">>,
			%                                                    durable = true}),

			% 	    #'queue.declare_ok'{queue = Queue} =
			% 	        amqp_channel:call(Channel, #'queue.declare'{queue = queue_name(),  durable = true}),

			% 	    amqp_channel:call(Channel, #'queue.bind'{exchange = exchange(),
			% 	                                             queue = Queue}),

			% 	    amqp_channel:subscribe(Channel, #'basic.consume'{queue = Queue,
			% 	                                                     no_ack = false}, self()),

				{ok, Channel} = amqp_connection:open_channel(Connection),
				?LOG(#{channel => Channel, gap => "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"}),

			    % 一旦申明了一个交换机，就不能轻易改变交换机的属性重新申明，　如durable由true 改成false，　一旦改变就会报错
			    %　除非先删除旧的申明　，

			    amqp_channel:call(Channel, #'exchange.declare'{exchange = exchange(),
			                                                   type = type(),
			                                                   durable = true}),

			    #'queue.declare_ok'{queue = Queue} =
			        amqp_channel:call(Channel, #'queue.declare'{queue = queue_name(), exclusive = false, durable = true}),

			    amqp_channel:call(Channel, #'queue.bind'{exchange = exchange(),
			                                             queue = Queue}),

			    % io:format(" [*] Waiting for logs. To exit press CTRL+C~n"),

			    amqp_channel:subscribe(Channel, #'basic.consume'{queue = Queue,
			                                                     no_ack = false}, self()),

				    {ok, Channel, Connection};
		_ -> 
			conn_fail
	end.


