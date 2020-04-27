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
4. `elm` CLI does not have tab completion for commands or flags
5. To find the bootstrap code for js code (to seperate js from HTML), I had to do
`elm make --output textFields.js src/Main.elm && elm make src/Main.elm && diff index.html textFields.js` and then found:
```js
try {
	var app = Elm.Main.init({ node: document.getElementById("elm") });
}
catch (e) {
	// display initialization errors (e.g. bad flags, infinite recursion)
	var header = document.createElement("h1");
	header.style.fontFamily = "monospace";
	header.innerText = "Initialization Error";

	var pre = document.getElementById("elm");
	document.body.insertBefore(header, pre);
	pre.innerText = e;

	throw e;
}
```
6. [summarize.sh](https://gist.github.com/evancz/fc6ff4995395a1643155593a182e2de7) does not work for Elm 0.19.1
    1. I hacked some small changes into [this one](./summarize.sh) and that works on my system (Windows WSL Ubuntu).


## dead code elimination

There is an article that suggest that [Elm does dead code elimination](https://elm-lang.org/news/small-assets-without-the-headache)
but then why does the *buttons/* app have the following unused functions and objects?
(only listing the first 15 here - there is a lot more)

```js
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });
var _Utils_compare = F2(function(x, y)
var _Utils_Tuple0_UNUSED = { $: '#0' };
function _Utils_Tuple2_UNUSED(a, b) { return { $: '#2', a: a, b: b }; }
function _Utils_Tuple3(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3_UNUSED(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }
function _Utils_chr_UNUSED(c) { return new String(c); }
function _Utils_update(oldRecord, updatedFields)
var _List_Nil_UNUSED = { $: '[]' };
function _List_Cons_UNUSED(hd, tl) { return { $: '::', a: hd, b: tl }; }
function _Debug_todo(moduleName, region)
function _Debug_todoCase(moduleName, region, value)
function _Debug_toString_UNUSED(value)
function _Debug_crash_UNUSED(identifier, fact1, fact2, fact3, fact4)
```
