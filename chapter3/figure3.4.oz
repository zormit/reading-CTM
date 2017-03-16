declare Sqrt SqrtIter Improve GoodEnough Abs in
fun {Sqrt X}
   Guess=1.0
in
   {SqrtIter Guess X}
end

fun {SqrtIter Guess X}
   if {GoodEnough Guess X} then Guess
   else
      {SqrtIter {Improve Guess X} X}
   end
end

fun {Improve Guess X}
   (Guess + X/Guess) / 2.0
end

fun {GoodEnough Guess X}
   {Abs X-Guess*Guess}/X < 0.00001
end

fun {Abs X} if X<0.0 then  ~X else X end end

{Browse {Sqrt 25.0}}