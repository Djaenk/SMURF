# Week 2

| Part           | Comments    | Points |
|----------------|-------------|--------|
| provided tests | All passed  |     65 |
| extras         | 3 failures  |      2 |
| Coding         |             |     25 |
| **TOTAL**      |             |     92 |


Nice job! :)

Failures in my torture tests:

- failed to parse:  let a = fn () { 99 }
                    let b = fn(){a()+1}
                    a() + b()

- failed to parse:  let a = fn(){fn(){123}}
                    let b = a()
                    b()

- your binding code doesn't check for duplicate definitions of a
  variable (two `let`s for the same variable)

- your binding code doesn't check for attempts to access a
  variable that hasn't been defined.
