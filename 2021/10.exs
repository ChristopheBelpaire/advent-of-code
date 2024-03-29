
defmodule AOC10 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse(&1))
    |> Enum.map(&score(&1))
    |> Enum.sum()
  end

  def part2(input) do
    scores = input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse(&1))
    |> Enum.map(&score2(&1))
    |> Enum.reject(fn(s) -> s == 0 end)
    |> Enum.sort()

    Enum.at(scores, div(length(scores), 2))
  end

  def parse(line) do
    line
    |> String.split("", trim: true)
    |> Enum.reduce_while([], fn(c, acc) ->
      if Enum.find(["{", "(", "[", "<"], fn(x) -> x == c end), do: {:cont, [c | acc]}, else: good_opposite?(acc, c)
    end)
  end

  def good_opposite?([h | t], c) do
    matches = %{"<" => ">", "{" => "}", "[" => "]", "(" => ")"}
    if (Map.get(matches, h) == c) do
      {:cont, t}
    else
      {:halt, {c, t}}
    end
  end

  def good_opposite?([], c), do: {:halt, {c, []}}

  def score({")", _}), do: 3
  def score({"]", _}), do: 57
  def score({"}", _}), do: 1197
  def score({">", _}), do: 25137
  def score(_), do: 0

  def score2({_, _}), do: 0
  def score2(l) when is_list(l) do
    points_map = %{"(" => 1, "[" => 2, "{" => 3, "<" => 4}
    Enum.reduce(l, 0, fn(c, points) -> (points * 5) + Map.get(points_map, c) end)
  end

end

AOC10.part2("[{(<<{(([<<{<<[]()>[<>[]]>[[<>[]]{{}{}}]}<<[<>()][{}]><[<>{}]<<>()>>>>([<([]<>)([][])>(<<>[]>([]()))]<[
{([[[{{([{{{([[]()][()<>])}[<<(){}><<>()>>{{[]<>}[(){}]}]}<<(<<>[]>{[][]}){<<>()>({}()}}><{
{[[([{([<(<{{[{}{}]<[]()>}(<<>[]><<>()>)}(<[<><>](<>[])><<(){}>{(){}}>)>{{[({}[]){[][]}]({()<>}<[]<>>)}})>({(
{[<([(<<{<<<[<{}{}>({}[])][<[]{}>{[]{}}]>{[{[][]}[{}<>]]{(<><>){{}[]}}}>([<[<>{}]([][])>{(<>{})}][{({
<{{[{[<(<[{[(<()<>>([][]))[[{}()]]]}<{<{{}{}}((){})>((()())([]{}))}<((<>{}))>>]<{[[<()[]>]{(<>[])
<((({<((<([<[<[][]>[[]{}]]<{[][]}({})>>{<<()>({}())>[(<>)<[]()>]}]{[{<<>[]>{{}<>}}<<()<>>([][])>]})[({{((
[{<[{<({({[(<{{}[]}[[]()]>{<()()><{}()>})({[{}<>](()())}({[]{}}({}{}))>]([[[<>[]]<()[]>]]([[<><>]({}
{(<[<<{([([(<[{}[]]<{}{}>><<()[]>([]<>}>)]{[[{()}({}())]<[<>[]]([]<>)>](<[[]{}](<><>)><[[]{}]{<>[]}>)})]
({([{[({{<([[([]())]{[[]{}]}]{<{(){}}<{}{}>><([]{})>})[(<{<>()}>{(<><>)[[]{}]}){{{{}<>}({}<>)}[<()
<[<[{((<<{[((<[]<>>[[]()]){{()[]](<>)})(({[][]}[[][]])[(<><>)<{}>])][<[{[]()}{[]()}][{<>{}}({}<>)
<({(<(<{[[({({()[]}<{}<>>)[<{}[]>{{}()}]}([[{}](()[])][{[]{}}(()[])])]{[[{()[]}]<[[][]][{}]>]}]<(<<<[]()>[
[<<<{((<{(<([[{}{}]{()<>}]{{{}<>}[<>()]}){[[[]()][[][]]]{([]())[()<>]}}>{({[<>()]}([[][]]<(){}>))<<<{}<
[[{(([(<{(<({[()()]([]{})}[({}<>)])([<[]{}><()<>>][<<>[]><<><>>])>)[[{[{()[]}{[]}]}]]}>)]{<{{(<[{[[]<>]<()[]>
<{(<[{{([{{[(<[]<>><()<>>){{{}{}}}]}(([[<><>]([][])]<{()}{{}()}>)<{[()<>][<>]}<(<>[])>>)}])
(<{({([<([<{<(<>()){()()}>([<>()]({}()))}><(([{}{}]{<>{}})<<[]()><[]{}>})<{([]<>)<[]()>}({{
[{([(({[(<[[{{{}<>}({}())}{{(){}}<<>>}]<<({}())(<><>)]<<<><>><()()>>>]({(<{}<>>{()[]})}<<{{}{}}({})><<<>(
(<[(({<(<{({{<()<>>{{}()}}}[[{()[]}{[]{}}]<({}())([]{})>])}{<{<(()[])([]<>)><<<>{}><{}[]>>}<[[<><>](()[]}]>>{
({({<({({(<{({{}{}}(()[]))(<{}{}>[{}()])}((<{}<>><()[]>)[(()<>)[{}<>]])>)}[[<<{<[]{}>{<>[]}}{{(){
({<<([(<<<(<{(()())[{}[]]}(<[]<>>[{}{}])>)<(<[{}[]]{[]{}}>({[][]}[[][]])>>><[{([[]()]{{}()
[({{[[(({[<[([{}[]])<<(){}>(()<>)>]({<[][]>[{}<>]}[<[]<>>])>({(<<>[]>{{}{}}){<[]{}><{}<>>}}([({}<
((<[[{({<<<([({}{})[[]<>]]{(()<>)[[]{}]})({{<>}[<>[]]}[[<>[]]<[][]>])>>>}[[<<{(<<>()>(()()))<{<>{}}(()
{{{[[[([{<(<[([]())[[]()]]<(()())([]{})>>([<[][]>]{({}()){()<>}}))><[([[<>[]][[]<>]][<()[]><{}{
[<{[(<<{({<({{()[]}[{}<>]}{({}<>)[(){}]})[<([]{})><([]<>){()()}>]>})}>[[<{[<<[<>()]<()<>>>{[{}{}]<<>[]>
<((((((<{(<([[<><>][<>[]]]{<{}<>>})>)(([<[()()]>[(<>[])<[]{}>]][<([]{})([]{})>{{[]}({}())}]){[[[()[
<([{((({{[({[[()]][{[]}{<>[]}]}<{<(){}>[[][]]}<([]())<[][]>>>)<<{<()()>({}())}{<()()>}>{{[{}()]}}>]}
<[({<[(<<<<{[[<>{}]([]{})]}>>>[<[[{(<>())([][]}}(<[]<>>)]<<{<>()}{[]<>}>{<()>([]())}>]<<[({}{})<[
[[([({<({{(<(<()()>(()<>))>[{<<>()>([]<>)}{{<><>}{{}[]>}]){([[[]()]<[]<>>](([]())<[][]>))}}}{<{<{<<>()
<<{[[<(({(({<{[][]}(<>{})>{(<>())}}{<[[]<>]<{}()>){{[]<>}[()]}}))}))>]]{{<<{{<<<{([][])<{}()>}[[<>()][()[]
{<{[[(<[((([<{[][]}[{}]>]((([][])([]()))([<><>](<>{}))))){(<[[(){}]<[][]>]>{((()()}({}[]))<[<>{}]{<><>}>
([[[[[([<{({{<[]<>><{}<>>}{{<>()}[[]<>]}}(<[<><>]{()()}>))<[{({}<>){(){}}}<({}())[()[]]>]{([()<>][[][]
({([(({<<{{[(({}[])([][]))[({}{})]]}([<<[]<>>([]{})>])]>>[{[[(<<()()><<>{}>>)(([[][]](<>[]))
{({[<({[({[([[(){}]{(){}}])]<{<<(){}>[{}[]]><{[]{}}[[]<>]>}{{{<>{}}[[][]]}[[[]<>]]}>}([{((<>[])<[][]>)}]
({([<(((({<[<<[]<>>{{}[]}>((<>{})<[]{}>)]>{(<{{}[]}({}{})><<()<>>(<>[])>)[{(())([]())}]}})))[{<(({{{[]{}}[<
<<([{{[[<<(<[{[][]}<{}{}>]<[{}{}]<<>{}>>><[[{}{}][{}]]<<{}<>>[{}()]>>)(<[(<>{})<()[]>]{(()())}><[[[]]<{}>][(<
{[[([<({[{[<[([]<>)<[]{}>][(<>())[[]<>]]>[([<>[]](<>))([()()]({}()))]]{{(<()[]>{{}[]>)[{<>}(()())]}}}{<{{
([[[(([{{<[{<[<>[]]<<>[]>><(()())<{}[]>>}(([[][]]<{}<>>))]<[[(<><>}{()()}][[{}[]][()[]]]](([{}{}]<[][]>)<[{}
{({{(<([[{({{<[]{}>[[][]]}{{<>()}<[]{}>}})({({[]})[<()()>{[]<>}]})}<{[[<{}>({}())]{{[][]}<[]()>>]([{(){
{([((<<{[{{[<({}())[()[]]>(<{}<>>({}()))]}}<{<([[][]]([]{})){(<>[]){()[]}}><[({})[<>[]]][(
{(((<[([({(([{<>}<[]{}>]))}({{([<>{}](<>{})){(<>{}){[]{}}}}[[[<>[]]]<{()<>}{<><>})]}({({[][]}<[]{}>)[{[]{}}]}
[{(({<[{(([{<[()[]]<[][]>>([{}<>][()()])}([<<>[]>[[]{}]][<{}[]>({}())])]<({({}[])}[{()()}[{}[]
[[{{<<<[[{<<[<[]{}><()[]>]{[[][]]{<><>}}>>{({[[]{}][<><>]}(([]<>)<<>()>))(([{}<>]<[][]>)<([]<>)((
[{{(({[(({[[<[(){}]>(<{}<>>)]<(([]<>)<<>()>)[<[]{}>{<>()}]>]({<[[]{}]{<><>>>}<([<>()][[]<>]
[{<<{{(((<[[{(<>{}){[]<>}}((()[])[()<>])]<[[()]](<<>[]>[(){}])>](<({{}[]}<()<>>}<[[][]]<{}<>
<[(<{[[[{[{[[[[]<>)({}())]([()()][(){}])][<{[]()}[(){}]>[[(){}](<>())]]}<[{[()<>]{[]<>}}{<()()>}](
{[<<[{{([{<[([{}()]([][]))<([]())<<><>>>]<(([]<>)[{}]){<{}()>({}<>)}>>{<<<<><>>(()[])><{{}{}}<[][]>>>{([{}[
((({[<<<(<[<<{<>{}})[<{}<>>]>{[({}<>){[]}](([]<>)<(){}>)}]>{{<{<{}{}>[[]{}]}({[][]}<()[]>)><{{()}{{}}}[{{}{}}
{(([{[({[([[<([][])(()<>)>(<(){}>[<>[]])]<{[<>[]]({}[])}(<[]{}>{{}{}})>])<<({[()[]]((){})}{{{}{
([(<{(<<((([<{[]}>[[[][]](<><>)]][<([]){<>{}}>{[<>{}]}])(<[{<>{}}({}<>)]([()[]]([]<>))>))<{<([()
<<{{({<{{{<<({(){}}<[]{}>)><([(){}]({}[]))[[{}()]({}())]>>{<<[{}[]]{()<>}><[[]<>][()<>]>>[{
[[[{{{[{[(<(([()[]]<(){}>))[(([][])[<>])<([][]){<>()}>]>{[<<()[]><{}[]>>((<>)[(){}]))})(<<[{()()}<()
<{[{((<({<<[<<{}()>[(){}]>[(()()){<>()}]](<[{}<>][{}()]>{<(){}>})>>[<<[<(){}>[<>{}]]>((<()()>{<>
{((<[<([(({[<<{}<>>{<><>}>[<()()><{}[]>]][{[[][]]{()()}}[[<>]{{}()}]]}<(<(<>{})<()<>>>{{()
{(<[(<([{<<<({{}()}({}<>))[<[]><[]<>>]>{<<{}<>>[[]()>>}>[{<<{}()>[[]{}]>}{{{()<>}}}]>}]){(<[({<<<><>><[][]>>}
<[<[(([{<[<{[{[][]}{<>[]}])>][([[[[]{}][{}<>]][[{}{}]]]){(({<>[]}[<>[]]){{[]{}}{()()}})<(<[]<>><[][]>)>}]>}[
{(<[[[(<([[{{[()[]]{<>()}}{<[]{}>{<>[]}}}(<([]<>)([]())><<()[]>(<>{})>)]]([<([<>](())>{{<><>}<(){}>}>][<(
<<[([[{<[[[[{([]())<<>[]>}]({{{}{}}({}[])}<{()[]}<()<>>>)]{{<({}())[<>[]]><{<>}(()<>)>}([({}{})[<>]
{([({[(({{<[[{{}()>[<>]]({<>[]}(()()))]([[()<>]([]())]{[()[]](<><>)})>{[<<()()><(){}>>[[()()][
{[[{<{([(([[{({}[]){()()}}{(<>{})[[]<>]}]<[[{}<>]<[][]>]((()[]))>])){(<<([[]{}]([]{})){<{}<>><()()>}>{<{[]
<{({(({{{([<{[()[]]<()<>>}{({}())[{}{}]}><(([]())<<>[]>)<{[]()}[(){}]>>)({(<()>)([{}{}][()<>])}[<[[]<>][()()]
[{{(((([{[{(<(<>())([]{})>[([][])({}[])])<{<(){}>[[][]]}[<[]()>{[][]}]>}((<([]()}{[]{}}>){<({})><{(){}}>})
{(<{<((((<(<<<[]<>>(<>())>{[{}[])<[]{}>}>)><[[([{}<>]{{}<>})<{()()}{<>{}}>]{[<()()>{()[]}][[<
{(<<[<((<<<<{{<>{}}{<>{}}}[(()())<<>()>]>[[([]())<{}()>]((<><>)<<>[]>)]>{([<()()>[{}]]{[<>[]]<<>()>})<<({}<
<{[{(((<({<<((()<>){[][]})[{[]<>}[[]<>]]>>})>))[<{{{[<{[{}{}]<[]()>}<{()[]>>>[<<{}{}>{<><>}>[[<>{}][{}<
[[{<{<[[<{(([<[]<>>{[]()}]){[<[]<>>[{}]](<(){}>[[][]])})}>]][[<(<<[[[][]][[]()]]<[[]<>]>>>{[({{}()}<{}<>>)]<(
{{((([<((<<[[{()}(()[])]][([(){}]<[]<>>)]>(([[{}()][()[]]](((){}){(){}}])({[<><>]<{}{}>}(([][])<<>{}>)))>)((
<{([[(<{[<[[[([]())<<>()>][<{}{}>{{}{}}>]{[({}{})({}<>)][(<>{})<{}()>]}]([{{{}()}{[][]}}])>([
<[<{{<<{{[[(([(){}]({}[]])({<><>}<[]{}>))]{<(({}())){<[][]>}>{{({}<>)[[]<>]}(<<>[]>[[]<>])}}]}}>>[{
(<<<{({[[[[<{(<><>){()()}}>{[<<>{}>([]{})][[{}<>][[]{}]]}]<{((<>{})[()<>])(({}()){{}()})}>]]{{({[((){})](<[]
<[{<{{[<[{{([(<>())[(){}]]<[<>()]<()<>>>)}}][<[(([()<>]({}())){(()[])<{}()>])<[(<>[])({}())]>]{((
<{{[{{([<{([((<>{})({}{}))](<({}[]){()<>}>(({}())[[]()]))){([[<>{}]{()<>}])}}<(<[<()[]><()<>>]}<({[]<
{({[[({<{{[[([()])<{()[]}{<>[]}>]]}}>[((<[<([]())({}())>]<<{<>[]}[{}<>]>>>{[[([]{})([])}{<<><>>{<>()}
<<{{<(({[<<(((<><>){{}[]})(<{}[]>))[<<[]{}>([]{})><<[]<>>>]>{{(([]()){<>{}}){{<>[]}((){})}
{<{[({{<{[(([<(){}><[]<>>})[(<()[]>({}<>))({[]{}}[[]<>])])][<{<<[]()>{{}[]}>}{(([]){{}<>}){<{}{}><{}
[[{([<[<[{<([(()<>)}[[{}{}]<[]()>])[[<()[]>]([{}{}][()<>])]>([[<<>{}>]{{[][]}[(){}]}][{[()()](<><>)}])}{<<<
[[[{[<<<<<[(([<><>])<<{}[]><{}()>>)[[<<>[]>[()[]]]{(()<>){<>{}}}]]<<({[]{}}[[]()]){(()<>)[[]{}]}>(({{}{
[[(([{{<([{[[<()()>({}[])]{<<>[]>((){})}]({{{}}<{}>}((()())({}[])))}(<[{[]}([]<>)]>{{<()<>>(<>{})}
(((({[(<{(<{<[()()][{}<>]>}{<<{}<>>[()[]]>}><<{{()[]}[[][]]}>>)}>>]{([[([({[{}()][<>{}]}){<[{}()]<{}
{[[[{{[[<<{(({[]<>}){{[][]}<<><>>})[[[(){}]<<>{}>]{<<>[]>{{}()}}]}>>]](([([{<[(){}][{}()]>{<[]<>><
<[[[{<<<{([{(<()()>)<[<>[]]({}())>}{{([]{}){{}}}[[(){}]<<>[]>]}](([<{}()>](({}[])[[]()]))<[[{}()]<{}[]>]>)
(({(({{<{{<((({}()))[<()()>[<>{}]])>}{{{[[{}<>][{}[]]]{<<><>><<>[]>}}}}}>}}[({{({[<[[]()][
((({[<{[((<[[<<>{}>}{{<>[]}}]>){{({{<>{}}}{{()()}(<>[])})({<[]()>[()()]}{<[]()>{[]{}}})}<[(<()()>{{}
([{{(<<<<[([[{{}{}}<{}<>>]<({}{}){()}>]{{{()<>}[[]{}]}[{[]<>}{<><>}]})][{[[(<><>)[{}<>]][([](
{<<<[[({<{[({(<><>)[<><>]}{[(){}]{<>[]}})]{<([<>{}]{()[]})((<>()))>}}>[[<[{<{}()>}(({}<>)[{}[]])]<{(<>[]
[({(<[[<[<({({<>[]}{(){}}){([]()>(()[])}})>[[{(<()[]>[<>()])}{[[<>()]({}[])]{(()[])<()<>>}}]]]([{{<<()[]
{[([(([[{<<<{<[]>{<><>}}{{[]}(()())}><[{<>()}[<>[]]]([<><>]([]{}))>>{(({<><>}))({{{}[]}<<>[]>}[{{}()}])}
[([<[{([<<<(<{()<>}<[]()>>{[<><>][<><>]})([{{}}]{{{}[]}(<><>)})>>(({{({}[])<[]>}[(<>())(<><
[{[{[((<[[[<([<>[]](<><>))({{}()}[()()])>]>]><[{{{((<>[])<()()>)<[()[]]>}<([{}<>]({}())){{()[]}{[]<
{{{[{([<(<<[([()<>]<()()>)(<<>()>(()[]))]<<({}<>)[{}]><<[]<>>{{}[]}>>>>)>(([(<[{()<>}{{}()}]([(
({{{[({[{[({([{}<>]([]<>)){<<>[]>}})<[<[()]<[]>>]<<{{}[])[{}{}]>>>]}(<({{[<>{}]}([(){}]{{}<>})
{[(({{{([({({(()())[<><>]}{<[][]>(()[])}){[{<>()}[()[]]]<{<>[]}[[]{}]>}}[(<{[])[<>[]]>({{}[]}[()<>]))]){{[{<{") |> IO.inspect()
