-module(khf1).
-author('marton.metzing@gmail.com').
-vsn('2017-10-09').
-export([cella/2]).
%-compile(export_all).

cella(S, I) ->
    MatrixWidth = length(S),
    CellWidth = trunc(math:sqrt(MatrixWidth)),
    XIndex = trunc((I - 1) / CellWidth),
    SelectedLines = lists:sublist(S, (XIndex * CellWidth) + 1, CellWidth),
    YIndex = trunc((I - 1) rem CellWidth),
    TrimConcat = trimLists(SelectedLines, YIndex, CellWidth),
    transpose(TrimConcat,CellWidth).


transpose(List,CellWidth) -> 
    getColumns(List,1,CellWidth,[]).

getColumns(_,Index,CellWidth,Result) when Index > CellWidth -> 
    Result;
getColumns(List,Index,CellWidth,Result) ->
    getColumns(List,Index + 1, CellWidth, lists:append(Result,getColumn(List,Index,CellWidth,[]))).


getColumn([],_,_,Result) -> Result;
getColumn(List, ColumnIndex, CellWidth, Result) ->
    getColumn(lists:nthtail(CellWidth,List),ColumnIndex,CellWidth,lists:append(Result,[lists:nth(ColumnIndex,List)])).


trimLists(SelectedLines, YIndex, CellWidth) ->
    trimEachList(SelectedLines, YIndex, CellWidth, []).

trimEachList([], _, _, Result) -> Result;   
trimEachList([Head|Tail], YIndex, CellWidth, Result) ->
    Trimmed = sublist(Head, (YIndex * CellWidth) + 1, CellWidth),
    trimEachList(Tail, YIndex, CellWidth, lists:append(Result,Trimmed)).

%%A gyakorlat megoldás alapján
sublist([], _, _) -> [];
sublist([H|_], 1, 1) -> [H];
sublist([H|T], 1, N) -> [H|sublist(T, 1, N-1)];
sublist([_|T], S, N) -> sublist(T, S-1, N).