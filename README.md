Preface
========

* "The main criterium for presenting a model is whether it is useful in practice"
* "how do we decide on what concepts to add?" -> "creative extension principle"
* Kernel language: The (minimum?) language, a concept is based on.
* Three example problem areas of informatics: graphical user interface design, robust distributed programming, and constraint programming. -> what is the third?
* xxxi: The MMIX approach by Donald Knuth would be a "virtual machine"?
* Meta/Technical Q: Is it possible to add Outline to an existing PDF?
* TODO: Get clear about the difference between concepts, computation models, paradigms

Chapter 1
=========

* In 1.7 I wondered, whether how often we are programming an algorithm for mathematical things that are, in fact, computable in O(1)?
* To continue on this, an IDE might detect this attempt and provide information about how to circumvent the computation time.
* FastPascal is following some basic form of Dynamic Programming, right? Where does DP fit in this concept landscape anyway?
* 1.8 "what does it display?" => 0+1+2 => 3
* 1.9 Is "Higher Order Programming" now a concept? paradigm? or rather sub-paradigm?
* 1.11 is the "start" a string? why? b/c lowercase?
* What if the variable was not bound by accident?
* 1.13 what makes this an "object"? the state only? also this showed encapsulation -- is e. a necessary property of objects?
* 1.15 Do not use state and concurrency together! This reminds me of ["Boundaries" by Gary Bernhardt](https://www.destroyallsoftware.com/talks/boundaries). The trick is to split functional parts from the "object" parts.
* declare introduces a new store.
* generic pascal -- broken example
* Memory Model of Oz vs. Single Static Assignment (SSA) => Oz: variable != identifier -- SSA: identifier to value. https://en.wikipedia.org/wiki/Static_single_assignment_form
* Rebounding/Shadowing? New scope is created by "declare".
* Higher Order Programming is a feature that comes with other paradigms (first class functions, such that it can be referenced) -- there could even be HOP in Assembler and C, but do you want this?

Chapter 2
=========

* Programming encompasses:
  * computation model
  * programming model
  * reasoning technique
* Simplest computation model: Declarative programming.
  * Definition: "Defining functions over partial data structures" (i.e. stateless)
  * Combines functional and logic programming.

2.1 Syntax and Semantics
------------------------

* Syntax -- Grammar and Semantics -- Meaning of a (programming) language
* Syntax: What is a legal program?
  * structure via
    * statements/sentences -- sequence of tokens
    * tokens/words -- sequences of characters/letters
  * a grammar is useful for defining both of them
* Extended Backus-Naur Form
  * terminal symbol -> token
  * nonterminal symbol -> sequence of tokens
  * use grammar to verify _and_ generate statements.
  * a set of statements is called a *formal language*
* Many programming languages don't have a context-free grammar,
  e.g. because of variable declaration
* Two step approach for defining language syntax:
  1. context-free grammar (via EBNF) -> superset of the language
  2. set of extra conditions -> context-sensitive
* To disambiguate expressions:
  * different operators can have different precedence level
  * same precedence level needs associativity
* Semantics: What a program does when it executes.
  * ideally defined in simple mathematical structure for easier reasoning
* Kernel language approach:
  1. define the kernel language (should be very simple).
     Reasoning in it should be easy.
     Kernel language and data structure manipulation -> kernel computation model.
  2. define translation scheme from the full programming language:
     * linguistic abstraction
     * syntactic sugar
* each computation model has its kernel language which builds on its predecessor by adding one new concept.
* Approaches to language semantics:
  * operational semantics (statement execution on abstract machine)
  * axiomatic semantics (relation between states)
  * denotational semantics (function over an abstract domain)
  * logical semantics  (statement as a model of a logical theory)
* Linguistic abstraction
  * abstraction and new feature at the same time, e.g. for-loop.
  * two phases: define grammatical construct, then define translation to kernel.
  * in this book: functions, loops, lazy functions, classes, reentrant locks and others
* the kernel language for declarative programming uses procedure syntax
  * all arguments are explicit
  * multiple outputs
* syntactic sugar: short cut notation, e.g. "local" statement without providing new abstraction.
* Translation approaches:
  * kernel language approach: it's concepts correspods to programming concepts
  * foundational approach: for doing maths with it (e.g. Turing machine, lambda calculus)
  * machine approach: for implementors -> programs translate into a virtual machine.
* interpreter approach is an alternative to translation approach: a program written in one language that accepts programs of another one. (SICP approach)

2.2 The single-assignment store
-------------------------------

* SAS "is a set of variable that are initially unbound and that can be bound to one value".
* variables in the SAS are called declarative variables (or dataflow v.)
* binding it makes it indistiguishable from its value.
* value: a mathematical constant
* value store: persitent mapping from variables to values
* in this book we're using single-assignment store _instead_ of a value store or a cell store. why?
  * to compute partial values (via unbound variables)
  * declarative concurrency (cf. Ch. 4)
  * necessary for extension with constraint programming.
  * efficiency
* Value creation: "The single-assignment operation x_i=value constructs value in the store and then binds the variable x_i to this value."
* store entities: variables and values.
* variable identifier: refers to a store entity from outside.
* environment: mapping between variable identifiers and store entities.
* <x> represents "any identifier" (in the grammar)
* dereferencing: following the link of a bound variable to its value. invisible to programmer.
* complete value: a partial value with no unbound variables.
* "a set of partial values is compatible if the unbound variables in them can be bound in such a way as to make them all equal"
* ??? Q: in 2.2.7 why is binding Y to X via X=Y enough to make it circular?
  * cf. also p. 108
* variable use error: trying to access variable before binding it.
* four cases of dealing with "variable use error":
  * continue execution, use garbage value
  * continue execution, use default value
  * stop execution, raise exception
  * continue execution, wait until variable is bound
* dataflow variables: those variables that cause the program to wait. (super useful in concurrent programming)

2.3: Kernel language
--------------------

* Q: A <feature> (Table 2.2) is not in the hierarchy. What is it?
  * name for a slot in a record. (see 2.3.4)
* Q: Are <record> and <pattern> equivalent?
  * Same syntax, but different. As all compound strucutures are <records>, all <pattern>s need to match <records>.
* Q: How are <atom>s and Variable identifier related? (the latter denoted by <x>, <y> and <z>)
  * A: An atom is a record with no features.
* complete lists: ending on nil. Can be written with brackets, e.g. [1 2 3] means 1|2|3|nil.
* symbolic languages: those with good support for taking apart and manipulating records.
* Q: what are procedures anyway?
  * take in identifiers (can be unbound, those are the return values)
  * you could have proc that defines bump/read on variable. bump once -> variable is bound.
  * how to think about unbound?

2.4: Kernel language semantics
------------------------------

* `local` creates new variable and sets up an identifier to refer to it.
* lexical scoping (or static scoping): the scope of a `local` identifier is only until `end`. For procedures: Use the variable that are available at *definition*-time.
* dynamic scoping: use the environment that is available at *execution-time*. Used for calls to common library operations, to be more efficient.
* ??? Q: Can somebody explain me the error message "unification erro", i.e. what happens in the background when a procedure is defined without declaration.
* Call by reference: A procedure can bind unbound variables that are passed in from the outside.
* free identifiers: undeclare identifiers. can be declared by listing them as parameter in a procedure. ". A free identifier in a statement is an identifier that is not defined in that statement. It might be defined in an enclosing statement.
* procedural abstraction: _any_ statement can be abstracted into a procedure.
* Q: p.115, 4.: shouldn't Max->... be in the Env as well?
  * No, because it is not used in the "body". If it were used, it would be an external reference.
* Q: p.115, 6.: There is no E anymore right?
  * There would be, if we'd "use" C further on.
* ??? Q: is the last-call optimization already given? I don't get 2.4.6.

2.5: From kernel language to practical language
-----------------------------------------------

* Q: difference between statement and expression?
    * "An expression is syntactic sugar for a sequence of operations that returns a value."
    * So the kernel language does not have expressions by default. Interesting. Cf. Table 2.1 on p. 50.
      Table 2.2 talks about "Value Expressions", which seems to be "value" later on.
* Q: can we talk about the nesting marker? Does something like that exist in another language?
    * e.g. how does the $ work on p. 87 in the map example?
    * works because of Unification! Binds the function to the name.
* I find the unbound variable Y at the end of p. 87 remarkable
* Did somebody play around with the things in Chapter 2.5? There was not so much "runnable" code.
* ?? Q: difference between declare and declare in?
* [103] Donald E. Knuth. Structured programming with go to statements. Computing Surveys, 6(4), December 1974.
* wow: "In other words, an exception can be raised (and caught) before it is known which exception it is!"

Chapter 3
=========

3.1: What is declarativeness?
-----------------------------

* Q: Table 3.1. defines a language whose programs are declarative, right?
     Not: This table _is_ a declarative program.

3.4: Programming with recursion
-------------------------------

* Oh, I'm surprised that we didn't have an append function. But makes sense...
* Q: " e.g., {Nth 1|2|3 2} returns 2 while 1|2|3 is not a list." -- what is it? (p.134)
    * list type can be used to store non-list structures.
* Why no array?
    * Tradition. Oz is biased heavily towards functional, although it claims to be declarative.
    * Language should've been simple for paper publications
    * Persistent arrays are too tricky
* 3.4.2, p. 139ff: Q: So LengthL2 is wrong, because it accepts symbols, right?
* 3.4.3, p. 142: Q: What should this P1/P2/P3 think be?
  * Ok, after reading the following example: These are intermediate recursive calls to calculate the resulting Sn state.
* "We no longer program in this style; we find that programming with explicit
state is simpler and more efficient (see Chapter 6)" -- haha very funny ;-)
* "The limitation of using difference lists is that they can be appended only once." -- Q: But the result can be appended with something new, right?
* 3.4.3, p. 147/148: I'm not sure if I can "see" the difference list that is passed around in the functional FlattenD.
* same page: "It is perfectly allowable to move the equate before the reverse (why?)" -- yeah, why? Because Y is unbound, right?
* 3.4.3, p. 149: What intermediate state are they talking about? Rs?
* 3.4.4 (Queue): Q: Can we discuss what "ephemeral" means?
* Queue -- cf. Singly linked List C (pointers)
* regarding the amortized constant-time ephemeral queue: How does this not use dataflow variables?
* The X in {Delete Q X} is an output, right?
* I didn't really understand the ForkD/Q code.
