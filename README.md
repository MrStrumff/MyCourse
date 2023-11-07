# MyCourse
My personnal LaTeX class for writing my high school courses.

## Features

- Customizable color palette
- Customizable title pages
- Full math support
- Custom theorem environments
- Text with holes
- Fancy boxes
- Main text font and math numbers : Inter Sans
- Math main font : STIX Two Math
- Math font for blackboard letters : Cambria Math

## Custom environments

- `theo`, `theo*` environments for theorems
- `defin`, `defin*` environments for definitions
- `rem`, `rems`, `rem*` environments for remarks
- `prop`, `props`, `prop*` environments for properties
- `lem`, `lem*` environments for lemmas
- `coro`, `coro*` environments for corollaries
- `ex`, `exs`, `ex*` environments for examples
- `exo`, `exos`, `exo*` environments for exercises
- `rep`, `reps` environments for answers to exercises
- `meth`, `meths`, `meth*` environments for methods
- `resume` environment for a box with a customisable title
- `exotc` environment for a box with a numbered titled exercise.
- `demo` environment for proofs

## Specific macros

In `eleve` mode (default)
- `\Trouer{text}` replace the `text` by dots
- `\TrouerL[num-lines]{text}` replace the `text` by `num-lines` lines of dots

To switch between `eleve` and `prof` mode, use the macro `\ToProf` to enable `prof` mode and display texts hidden by the `\Trouer` and `\TrouerL` commands.
