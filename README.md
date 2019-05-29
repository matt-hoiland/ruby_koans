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
