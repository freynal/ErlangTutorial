-module(game).
-include("records.hrl").
-export([start/3]).

start(Character, Inventory, Map) ->
	start(Character, Inventory, Map, 0).

start(Character, Inventory, Map, Position) ->
	[Scene | _] = [M || M <- Map, M#map.position == Position],
	io:format("~s~n", [Scene#map.description]),
	if
		Scene#map.items =/= [] -> lists:map(fun(X) -> io:format(X#item.description ++ "\n") end, Scene#map.items);
		true -> pass
	end,
	if
		Scene#map.monsters =/= [] -> io:format("monst\n");
		true -> pass
	end,
	if
		Scene#map.paths =/= [] -> printPaths (Scene#map.paths);
		true -> io:format("Aucune issue !")
	end,
	Action = string:strip(io:get_line("\nQue faites-vous ? > "), right, $\n),
	handleInput(string:tokens(Action, " "), Character, Inventory, Map, Position),
	lose().

printPaths(Paths) ->
	lists:map(fun({Card, Desc, _}) -> io:format("Au ~s, ~s\n", [Card, Desc]) end, Paths).

handleInput(unknown, Character, Inventory, Map, Position) ->
	utils:printHelp(),
	start (Character, Inventory, Map, Position);

handleInput(Action, Character, Inventory, Map, Position) ->
	utils:clean(),
	case Action of
		["go" | _] -> start(Character, Inventory, Map, go(Map, Position, lists:last(Action)));
		_ -> handleInput(unknown, Character, Inventory, Map, Position)
	end.

go(Map, Position, Direction) ->
	[Scene | _] = [M || M <- Map, M#map.position == Position],
	case [NewPosition || {Dir, _, NewPosition} <- Scene#map.paths, Dir == Direction] of
		[Head | _] -> Head;
		_ -> io:format("can't go there\n"), Position
	end.

get() ->
	pass.

look() ->
	pass.

attack() ->
	pass.

use() ->
	pass.

open() ->
	pass.

enter() ->
	pass.

win() ->
	{true}.

lose ()->
	{false}.