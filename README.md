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
