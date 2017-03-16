declare
X=person(name:25 2:"a" age:"George")
{Browse {Arity X}}
{Browse {Label X}}

declare
proc {Max X Y ?Z}
   if X>=Y then Z=X else Z=Y end
end

local C in
   {Max 3 5 C}
   {Browse C}
end

declare
proc {LB X ?Z}
   if X>=Y then Z=X else Z=Y end
end

local Y LB in
   Y=10
   proc {LB X ?Z}
      if X>=Y then Z=X else Z=Y end
   end
   local Y=15 Z in
      {LB 5 Z}
      {Browse Z}
      {Browse Y}
   end
end

local P Q in
   proc {Q X} {Browse stat(X)} end
   proc {P X} {Q X} end
   local Q in
      proc {Q X} {Browse dyn(X)} end
      {P hello}
   end
end