-module(fizzbuzz).
-export([run1/1, run2/1, run3/1, run4/1, run5/1, run6/1, run7/1]).

prnln(X) ->
	io:format("~p~n", [X]).

%%========================================================================
%% На генераторе списка с case-ом и матчингом и выводом всего списка
%%========================================================================
run1(N)-> prnln(
                    [	
                        [
                            case {X rem 3, X rem 5} of 
                            {0, 0} -> "fizz_buzz";
                            {0, _} -> "fizz"; 
                            {_, 0} -> "buzz"; 
                            _ -> X end 
                            || X <- lists:seq(1, N)
                        ]
                    ]
               ).

%%========================================================================
%% На генераторе списка с case-ом и матчингом и выводом поэлементно
%%========================================================================
run2(N)->
    List = [
            case {X rem 3, X rem 5} of 
                {0, 0} -> "fizz_buzz";
                {0, _} -> "fizz"; 
                {_, 0} -> "buzz"; 
                _ -> X end 
                || X <- lists:seq(1, N)
           ],
	lists:foreach(fun prnln/1, List).

%%========================================================================
%% Аналог классического цикла с if-ом
%%========================================================================
run3(N) ->
    run3_n(N, 1).

run3_n(N, K) when K =< N ->
    if 
        (K rem 3 == 0) and (K rem 5 == 0) -> prnln("fizz_buzz");
        (K rem 3 == 0)                    -> prnln("fizz");
        (K rem 5 == 0)                    -> prnln("buzz");
        true                              -> prnln(K)
	end,
    run3_n(N, K + 1);
run3_n(_,_) -> ok.

%%========================================================================
%% Аналог классического цикла с case-ом и матчингом
%%========================================================================
run4(N) ->
    run4_n(N, 1).

run4_n(N, K) when K =< N ->
    case {K rem 3, K rem 5} of 
        {0, 0}  -> prnln("fizz_buzz");
        {0, _}  -> prnln("fizz");
        {_, 0}  -> prnln("buzz");
        _		-> prnln(K)
    end,
    run4_n(N, K + 1);
run4_n(_,_) -> ok.

%%========================================================================
%% Аналог классического цикла с клозами функции (с "гардами")
%%========================================================================
run5(N) ->
    run5_n(N, 1).

run5_n(N, K) when (K rem 3 == 0) and (K rem 5 == 0) and (K =< N) -> 
    prnln("fizz_buzz"),
    run5_n(N, K + 1);
run5_n(N, K) when (K rem 3 == 0) and (K =< N) -> 
    prnln("fizz"),
    run5_n(N, K + 1);
run5_n(N, K) when (K rem 5 == 0) and (K =< N) -> 
    prnln("buzz"),
    run5_n(N, K + 1);
run5_n(N, K) when (K =< N) -> 
    prnln(K),
    run5_n(N, K + 1); 
run5_n(_, _) -> ok.

%%========================================================================
%% Применение функции с выводом поэлементно над списком
%%========================================================================
fb1(K) when (K rem 3 == 0) and (K rem 5 == 0) -> prnln("fizz_buzz");
fb1(K) when (K rem 3 == 0)                    -> prnln("fizz")	 ;
fb1(K) when (K rem 5 == 0)                    -> prnln("buzz")	 ;
fb1(K)                                        -> prnln(K).

run6(N) ->
    lists:foreach(fun fb1/1, lists:seq(1, N)).

%%========================================================================
%% Применение функции над списком с выводом всего списка
%%========================================================================
fb2(K) when (K rem 3 == 0) and (K rem 5 == 0) -> "fizz_buzz";
fb2(K) when (K rem 3 == 0)                    -> "fizz";
fb2(K) when (K rem 5 == 0)                    -> "buzz";
fb2(K)                                        -> K.

run7(N) ->
    prnln(lists:map(fun fb2/1, lists:seq(1, N))).
%%========================================================================
