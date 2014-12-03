-module(utils).
-include("records.hrl").
-export([printHelp/0, clean/0]).

clean() ->
	io:format("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
		"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n").

printHelp() ->
    io:format("\n+========================+\n"
                "|                        |\n"
                "|      How To Play       |\n"
                "|                        |\n"
                "+========================+\n\n"
                "Launch program: adventure <Your Name>\n"
                "Select a class\n"
                "Possible commands in game\n"
                "\tget <Item>\n"
                "\t\tgets an item\n"
                "\tlook\n"
                "\tattack <Ennemy>\n"
                "\tgo <Direction>\n"
                "\tuse <Item> on <Something>\n"
                "\topen door\n"
                "\tenter <Building>\n"
                "Good Game !\n\n").