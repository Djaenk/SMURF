# Week 2

| Part           | Comments    | Points |
|----------------|-------------|--------|
| provided tests | All passed  |     65 |
| extras         | 3 failures  |      4 |
| Coding         |             |     25 |
| **TOTAL**      |             |     94 |


Apart from the handful of failed tests below, a nice job!

Failures in my torture tests:

- the interpreter blows up given `if 0 { 99 }`. It should either raise
  an error or return 0.

- your binding code doesn't check for duplicate definitions of a
  variable (two `let`s for the same variable)

- your binding code doesn't check for attempts to access a
  variable that hasn't been defined.

# Week 1

| Part           | Comments    | Points |
|----------------|-------------|--------|
| 00-test_values | All passed  |     75 |
| 00-test_extras | All passed  |     10 |
| Coding         |             |     25 |
| **TOTAL**      |             |    100 |

I really have nothing to say about this. Very nice all around.