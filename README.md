# Initial thoughts for improvement

## Day 1
1. asset size - `elm make --optimize` optimize variable names but **does not:**
    1. eliminate dead code (in the simple examples dead code is 56.9%)
    2. reduce the boilarplate code at all
    3. there is no way to reduce boilarplate code from initial `elm.json` - everything is required
2. vscode `elm.json` schema is missing and version information is not fetched from registry (https://package.elm-lang.org/all-packages)
    1. Is there any way to get version information for a single package?
3. lots of links are not correct - mainly pointing to https://github.com/elm-lang/ instead of https://github.com/elm/
    1. ... start writing down URLs...
4. `elm` CLI does not have tabl completion for commands or flags
