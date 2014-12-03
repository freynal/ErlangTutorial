#!/usr/bin/env escript

-include("records.hrl").

main(["Help"]) ->
    compile:file("utils.erl"),
    utils:printHelp();

main([Name]) ->
    compile:file("utils.erl"),
    compile:file("character.erl"),
    compile:file("map.erl"),
    compile:file("inventory.erl"),
    compile:file("monster.erl"),
    compile:file("game.erl"),

    utils:clean(),
    io:format("\n+========================+\n"
                "|                        |\n"
                "|        Aventure        |\n"
                "|                        |\n"
                "+========================+\n\n"),
    utils:printHelp(),
    io:format("Bienvenue ~s !~n", [Name]),
    io:format("A tout moment, entrez '?' ou 'Help' pour voir le guide du jeu\n"),

    Character = selectClass(character:getClasses()),
    utils:clean(),
    io:format("\nVous etes desormais un ~s ~s !\n", [Character#character.class, Name]),

    io:format("Que l'aventure commence !\n\n"),
    io:format("Vous ne vous rappelez pas comment vous avez atteri ici.\n"
        "La seule chose que vous savez, c'est que vous n'etes pas en securite ici.\n"
        "Vous devez fuire. Rapidement.\n"),

    Inventory = inventory:initInventory(),
    Map = map:initMap(),
    {IsSuccess} = game:start(Character, Inventory, Map),
    utils:clean(),

    if
        IsSuccess =:= true -> 
            io:format("Congratulation for finishing the game !\n"),
            halt(1);
        true ->
            io:format("GAME OVER !\n"),
            {ok, [Again]} = io:fread("Try again ? (y/n) > ", "~s"),
            if
                Again == "y"; Again == "Y" -> main([Name]);
                true -> io:format ("Goodbye !\n"), halt(1)
            end
    end;

main(_) ->
    usage().

usage() ->
    io:format("usage: adventure name\nPlease enter a name like so : escript adventure Myname\nTo see the how to play guide use 'Help' vommand like so : escript adventure Help"),
    halt(1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  Character Selection                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selectClass(AllClasses) ->
    io:format("\nPlease choose a class from :\n"),
    lists:map(fun(X) -> io:format("\t(~c)\t\t~s\n", [hd(X#character.class), X#character.class]) end, AllClasses),
    io:format("\tMore    (To get a Class Description)\n"),
    {ok, [ClassRaw]} = io:fread("\nEnter your choice > ", "~s"),
    utils:clean(),
    selectClass(string:to_lower(ClassRaw), AllClasses).

selectClass (More, AllClasses) when More == "more" ->
    utils:clean(),
    {ok, [ClassRaw]} = io:fread("\nWhich class would you like a description of ? > ", "~s"),
    utils:clean(),
    character:handleInput(ClassRaw,
        fun character:printClassDescription/1,
        fun () -> selectClass(AllClasses) end,
        fun() -> io:format ("Not a valid class\n") end),
    selectClass(AllClasses);

selectClass (ClassName, AllClasses) ->
    utils:clean(),
    character:handleInput(ClassName,
        fun character:getClass/1,
        fun () -> selectClass(AllClasses) end,
        fun() -> selectClass("More") end,
        fun () -> io:format("Not a valid class\n"), selectClass(AllClasses) end).
