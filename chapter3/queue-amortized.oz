declare
fun {NewQueue} q(nil nil) end
fun {Check Q}
   case Q of q(nil R) then q({Reverse R} nil) else Q end
end
fun {Insert Q X}
   case Q of q(F R) then {Check q(F X|R)} end
end
fun {Delete Q X}
   case Q of q(F R) then F1 in F=X|F1 {Check q(F1 R)} end
end
fun {IsEmpty Q}
   case Q of q(F R) then F==nil end
end

declare Q1 Q2 Q3 Q4 Q5 Q6 in
Q1={NewQueue}
Q2={Insert Q1 peter}
Q3={Insert Q2 paul}
Q4={Insert Q2 mary}
local X in Q5={Delete Q3 X} {Browse X} end
local X in Q6={Delete Q4 X} {Browse X} end