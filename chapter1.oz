{Browse 9999*9999}

declare
V = 9999*9999
{Browse V}

{Browse 1*2*3*4*5*6*7*8*9*10}

declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end
end

{Browse {Fact 10}}

{Browse {Fact 100}}

declare
fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R})
end

{Browse {Comb 10 3}}

{Browse [5 6 7 8]}

declare
H=5
T=[6 7 8]
{Browse H|T}

declare
L=[5 6 7 8]
{Browse L.1}
{Browse L.2}

declare
L=[5 6 7 8]
case L of H|T then {Browse H} {Browse T} end

declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N==1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}}
               {ShiftRight {Pascal N-1}}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L}
   0|L
end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else
      nil
   end
end

{Browse {Pascal 20}}