-module(character).
-include("records.hrl").
-export([getClasses/0, getClass/1, printClassDescription/1, handleInput/4, handleInput/5]).

thief() ->
	#character{class="Voleur",
        description="\n\n<--;;------;;;-<<\t\tVoleur\t\t>>-;;;------;;-->\n",
        life=10,
        dexterity=8,
        force=2,
        magic=0}.

mage() ->
	#character{class="Mage",
        description="\n\n/X\\('-')/X\\b\t\tMAGE\t\t/X\\('-')/X\\b\n",
        life=6,
        dexterity=0,
        force=2,
        magic=12}.

warrior() ->
	#character{class="Guerrier",
        description="\n\n<===============][xxxxxO\t\tGUERRIER\t\tOxxxxx][===============>\n",
        life=10,
        dexterity=0,
        force=0,
        magic=0}.

getClasses() ->
    [thief(), mage(), warrior()].

getClass(Name) ->
    case Name of
        A when A=="voleur"; A=="v" -> thief();
        B when B=="mage"; B=="m" -> mage();
        C when C=="guerrier"; C=="g" -> warrior();
        _ -> #character{class="Juste quelqu'un qui passait par là"}
    end.

printClassDescription(Class) ->
    Character = getClass(Class),
    io:format("~s\n", [Character#character.description]),
    printStat("Vie  ", Character#character.life, 10),
    printStat("Dext ", Character#character.dexterity, 10),
    printStat("Force", Character#character.force, 10),
    printStat("Magie", Character#character.magic, 10).

printStat(Name, Value, Max) ->
    io:format("~s\t\t[~s]\t~p\n", [Name, string:left(repeat("#", Value),Max,$-), Value]).

handleInput(Name, Valid, Recursion, Default)->
    handleInput(Name, Valid, Recursion, Default, Default).

handleInput(Name, Valid, Recursion, More, Default) ->
    case string:to_lower(Name) of
        A when A=="voleur"; A=="v"; A=="mage"; A=="m"; A=="guerrier"; A=="g" -> Valid(A);
        D when D =="?"; D == "Help" -> utils:printHelp(), Recursion();
        "more" -> More();
        _ -> Default()
    end.

repeat(X,N) ->
    lists:flatten(lists:duplicate(N,X)).
