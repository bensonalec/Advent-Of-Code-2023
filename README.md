# Aoc
This repo contains my 2023 Advent of Code submissions.  
---
### Features
As well as this, there are a number of helpful features.  
- In `lib/aoc.ex`, the get_input function uses an environment variable called "AOC_TOKEN" to call the Advent of Code website and retrieve a days input.  
- You can run tests with `mix test`, and this will test the get_input function as well as each days code.  
- You can also use `mix test ./test/dayX_test.exs` to run the tests for a given day.  
- The command `mix create_day X` will scaffold a set of files for the given day X, including two example files for parts 1 (`./samples/dXp1ex.txt`) and 2 (`./samples/dXp2ex.txt`), a standard test suite for the given day (`./test/dayX_test.exs`), and a core file for the day (`./lib/dayX.ex`).  As well as this it will create a blank cell in the table below.  
As the competition goes on I'll add more tasks and QoL improvements.
---
### Structure
Each day has two functions to run each part, one that takes in no input (this one reaches out to the AoC site and gets the input), and one that takes in input (this is used to run test data).  
---
For now I'm not focusing on scoreboard times, but if I do I'll put my scoreboard times with each problem.
| Day      | Part 1 | Part 2 |
| ---------| -------| ------ |
| 1        | [X]    |  [X]   |
| 2        |        |        |