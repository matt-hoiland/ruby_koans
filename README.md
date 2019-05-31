ko·an
: *noun* `/ˈkōän/`
: 1. a paradoxical anecdote or riddle, used in Zen Buddhism to demonstrate the inadequacy of logical reasoning and to provoke enlightenment.

---

# The Path

Forked from [edgecase/ruby_koans](https://github.com/edgecase/ruby_koans), I endeavor to learn Ruby step by step. Whenever I encounter a new programming language, I am most interested in the following questions:

- What kinds of types are defined in a language?
- Are the types static or dynamic?
- Does the typing system use type inference?
- What paradigms does the language use?
- Are functions first class?
- What's the deal with scope?!
- How does it handle references vs. values?
- Are instances garbage collected?
- Does it allow for stack instantiation or restrict to just the heap?
- What algorithms manage the garbage?
- Does it use statements or just expressions?
- What is its philosophy on mutability?
- Does it have closures?
- What truly innovative features make it different?
- What are its native abstract data types?
- How broad is its object model? Are there nuances?
- How does the language handle namespacing, modularity, and encapsulation?
- What parts are syntactic sugar and what parts are core to the language?

This is not at all a comprehensive or rigorous set of questions to use when learning a new language. These things tend to be things that I stumble with when I assume the language behaves differently than I expected. I'll be looking closely for answers to these questions as I walk the path.

## This Workbook

I've replaced the original README for this document. This will be my running journal where I record my insights and answers. I'm starting at the top, no matter how basic it may seem.

I have also allowed my VCS to track the `koans/` directory itself (untracked by default) so that I can compare my changes and revert as necessary.

## Koan 1: Assertions

`assert` and `assert_equal` are clearly methods. I have a few questions:

- How are the signatures defined?
- Do they expect certain types?
- How are parameters made optional and/or methods overloaded?

Let's break a bit.

```ruby
assert 'hi' # => passed just fine
assert 0    # => passed just fine
assert nil  # => failed test
```

It seems that certain values have truthy and falsy interpretations.

```ruby
assert_equal one_value # => (given 1, expected 2..3)
```

Functions require a certain number of arguments.

## Koan 2: `nil`

`nil` is an object and not just a value! It's probably a singleton, immutable. It also has methods such as `#is_a?` defined.

Ruby uses exceptions; that's good to know. First exception foudn: `NoMethodError`. It looks like it resolves bindings at runtime; that makes it flexible (and dangerous).

`nil` is a singleton. It's documentation is here: [NilClass](http://ruby-doc.org/core-2.6.3/NilClass.html). It's got some interesting methods on it. It also has an interesting `object_id`: `8`.

```ruby
# THINK ABOUT IT:
#
# Is it better to use
#    obj.nil?
# or
#    obj == nil
# Why?

# Answer: `#==` can be overridden by a class. `#nil?` is defined from `Object` on down. Calling it will not cause a... whatever this language calls a null pointer exception. It appears that everything is an object.
```

## Koan 3: Objects

Weirdest thing guys: Literal values are objects! Mindbending.

```ruby
# THINK ABOUT IT:
# What pattern do the object IDs for small integers follow?

# Obvs it's 2n + 1, but why?
```

## Koan 4: Arrays

:astonished: Built it Arrays! Native abstract data types!

There's an insertion(?) operator: `<<`

Arrays are 0 indexed and can accept negative indices for reverse access. How do they handle out of bounds? ... They give `nil`.

Array slicing: appears to be `array[start, length]`. This is valid: `length >= 0` with no upper bound. If there are no more elements, it only gives what it has. It seems that if `start == array.size` then it gives an empty array. What about negative slices? ... `-array.size <= start <= array.size` and `length` cannot be negative. Also, the slice parameter doesn't accept a step option.

Ranges can be inclusive or exclusive:

```ruby
(a..b)  # interval equivalent: [a,b]
(a...b) # interval equivalent: [a,b)
```

Oddly, a negative value, doesn't do much:

```ruby
(2..-1).to_a  # => []
(-5...0).to_a # => [-5, -4, -3, -2, -1]
```

Ranges are weird, dude.

Arrays can be heterogeneous. They also have methods for deque operations. I wonder what their time-space complexities are.

## Kaon 5: Array Assignment

Arrays can be destructured! Coolio! And with a rest and spread operators! Destructuring doesn't require all variables to be present, like other languages with destructuring.

## Koan 6: Hashes (aka Python `dict` and JavaScript `Object`)

These examples map symbols to strings. Does the key *have* to be a symbol? Apparently not. `test_combining_hashes` uses string -> number.

Hashes can be accessed using the "indexing operator" or `Hash#fetch`.

```ruby
# THINK ABOUT IT:
#
# Why might you want to use #fetch instead of #[] when accessing hash keys?

# Answer: A key could be intentionally mapped to nil, and fetch will not raise
# the error in that case. Fetch *will* raise the error when the key doesn't
# exist.
```

!! Hashes are unordered. Literals with correct key-value mappings in any order are equal.

Key existence can also be checked with `Array#include?` since `Hash#keys` gives an instance of `Array`. The equivalent is also true for `Hash#values`.

`Hash#new` can accept a default value for index-like accesses. Another reason now to use `nil == hash[:doesnt_exist]` to test for key existence. The hash's default value could be something other than `nil`. The default value is a reference to the same object, however, so be careful. `Hash#new` can accept a block for initialization however.

## Koan 7: Strings

There are several ways to create a string literal:

- Double quotes: `"I'm a string."`
- Single quotes: `'I am also a string.'`
- Flexible quoting: `%(I guess I'm a string.)` `%!I'm a string.!` `%{I'm a string as well!}`
- Here Documents:

```
<<EOS
This is a string
EOS
```

They are __not__ equivalent however. Here are some differences:

- Double Quotes:
  - Use conventional escape sequences: `\n`, `\t`, `\"`, etc
  - Interpolate values: `"#{2 + 2}" == "4"`
- Single Quotes:
  - Only escape a few sequences: `\'` and `\\`
  - Do not interpolate
- Flexible Quotes:
  - Can be multiple lines, captures all characters between delimiters.
  - Escapes conventional sequences
  - Interpolate values
- Here Documents:
  - Interpolate values
  - Require opening and closing delimiters to be on their own line, with no whitespace preceding the closing delimiter.
  - Capture characters on the lines between the delimiters.

The `String#<<` operator behaves differently than `String#+=`.

Array slicing works for strings also in the same manner. `String#split` works as expected, accepting a regex as delimiters. `Array#join` is its counterpart.

`String#==` is defined properly.

## Koan 8: Symbols

Symbols are singletons. Method names are symbols. Identifiers are also symbols.

Passing a symbol literal to `Symbol#all_symbols#include` will always be true because the symbol literal exists.

## Koan 9: Regular Expressions

That's surprising. You can use the indexing operator with a regexp.

Capture groups are very interesting. I want to know how they get initialized.

Useful string functions for regexps:

- `String#scan` - Find all
- `String#sub` - Find and replace
- `String#gsub` - Find and replace all

## Koan 10: Methods

Method parentheses are optional unless it causes a syntax ambiguity. Argument count is a runtime error.

Some questions:

- Is the class of a method the same as its return type?
- With default arguments and variadic lists, what are the precedences? What are the restrictions on order?

Some notes:

- The rest operator (`*`) allows for variadic parameter lists.
- Arguments can be defaulted
- Methods return the value of the last evaluated expression if not explicitly declared
- Using explicit receivers is involved in determining access permissions

## Koan 11: Keyword Arguments

There are 3 kinds of arguments a method can have in that order:

- Required: `a`
- Optional: `b = 2`
- Variadic: `*c` of type `Array`

All of these types can also be keyword, put after the non-keyword arguments

- Required: `d:`
- Optional: `e: 5`, unlike optional args, these can be mixed with required kwargs
- Variadic: `**f` of type `Hash`

## Koan 12: Constants

Here we introduce namespacing paths:

```ruby
::TopLevelName
Namespace::Class::InnerClass::Constant
```

## Koan 13: Control Statements

All statements evaluate to values.

New to me structures:

- `unless` like `if !`
- `next` like `continue`
- `Integer#times`. Would you even consider that a "statement"

## Koan 14: True and False

Boolean logic, pretty fundamental. `nil` is falsey, and all other values are `truthy`.

## Koan 15: Exceptions

OBJECTS KNOW THEIR ENTIRE INHERITANCE ANCESTRY!!!!

- `begin...rescue...ensure` seems equivalent to `try...catch...finally`

## Koan 16: Iteration

How are blocks/procedures passed to methods?

- `Array#each` => for each
- `Array#collect` => map
- `Array#select` and `Array#find_all` => filter
- `Array#find` === `Array#find_all[0]`
- `Array#inject` => reduce
