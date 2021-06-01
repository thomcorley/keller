# keller
A command line interface for finding recipes. Named in honor of Thomas Keller, chef extraordinaire.

## Dependencies

* Ruby
* [Bundler](https://bundler.io/)

## Installation

1. `git clone git@github.com:thomcorley/keller.git`
2. `cd keller`
3. Install dependencies: `bundle install`
4. Add the following to your .zshrc or .bashrc profile:
```
export PATH=$PATH:/<PATH>/<TO>/keller/bin
```
5. Typing `keller` should display a random recipe in the terminal.

NB: The command should work from any directory, but you must be on the same Ruby version you used to run `bundle install`. Navigate back to the `keller` directory and run `ruby -v` to find out which version you need.
