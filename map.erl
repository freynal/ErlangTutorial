-module(map).
-include("records.hrl").
-export([initMap/0]).

initMap() ->
	[#map {
		position = 0,
		description = "test",
		monsters = [#monster{name="rapetou"}],
		items = [#item {description="une clef verte"}],
		paths = [{"nord", "Foret", 1}]},
	#map {
		position = 1,
		description = "toto",
		monsters = [],
		items = [],
		paths = [{"sud", "rap", 0}]
	}].