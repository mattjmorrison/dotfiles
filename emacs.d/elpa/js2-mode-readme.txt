This JavaScript editing mode supports:

 - strict recognition of the Ecma-262 language standard
 - support for most Rhino and SpiderMonkey extensions from 1.5 and up
 - parsing support for ECMAScript for XML (E4X, ECMA-357)
 - accurate syntax highlighting using a recursive-descent parser
 - on-the-fly reporting of syntax errors and strict-mode warnings
 - undeclared-variable warnings using a configurable externs framework
 - "bouncing" line indentation to choose among alternate indentation points
 - smart line-wrapping within comments and strings
 - code folding:
   - show some or all function bodies as {...}
   - show some or all block comments as /*...*/
 - context-sensitive menu bar and popup menus
 - code browsing using the `imenu' package
 - many customization options

Installation:

To install it as your major mode for JavaScript editing:

  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

Alternatively, to install it as a minor mode just for JavaScript linting,
you must add it to the appropriate major-mode hook.  Normally this would be:

  (add-hook 'js-mode-hook 'js2-minor-mode)

You may also want to hook it in for shell scripts running via node.js:

  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))

To customize how it works:
  M-x customize-group RET js2-mode RET

Notes:

This mode includes a port of Mozilla Rhino's scanner, parser and
symbol table.  Ideally it should stay in sync with Rhino, keeping
`js2-mode' current as the EcmaScript language standard evolves.

Unlike cc-engine based language modes, js2-mode's line-indentation is not
customizable.  It is a surprising amount of work to support customizable
indentation.  The current compromise is that the tab key lets you cycle among
various likely indentation points, similar to the behavior of python-mode.

This mode does not yet work with "multi-mode" modes such as `mmm-mode'
and `mumamo', although it could be made to do so with some effort.
This means that `js2-mode' is currently only useful for editing JavaScript
files, and not for editing JavaScript within <script> tags or templates.

The project page on GitHub is used for development and issue tracking.
The original homepage at Google Code is mentioned here for posterity, it has
outdated information and is mostly unmaintained.
