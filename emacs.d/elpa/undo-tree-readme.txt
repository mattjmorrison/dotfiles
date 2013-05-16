Emacs has a powerful undo system. Unlike the standard undo/redo system in
most software, it allows you to recover *any* past state of a buffer
(whereas the standard undo/redo system can lose past states as soon as you
redo). However, this power comes at a price: many people find Emacs' undo
system confusing and difficult to use, spawning a number of packages that
replace it with the less powerful but more intuitive undo/redo system.

Both the loss of data with standard undo/redo, and the confusion of Emacs'
undo, stem from trying to treat undo history as a linear sequence of
changes. It's not. The `undo-tree-mode' provided by this package replaces
Emacs' undo system with a system that treats undo history as what it is: a
branching tree of changes. This simple idea allows the more intuitive
behaviour of the standard undo/redo system to be combined with the power of
never losing any history. An added side bonus is that undo history can in
some cases be stored more efficiently, allowing more changes to accumulate
before Emacs starts discarding history.

The only downside to this more advanced yet simpler undo system is that it
was inspired by Vim. But, after all, most successful religions steal the
best ideas from their competitors!


Installation
============

This package has only been tested with Emacs versions 24 and CVS. It should
work in Emacs versions 22 and 23 too, but will not work without
modifications in earlier versions of Emacs.

To install `undo-tree-mode', make sure this file is saved in a directory in
your `load-path', and add the line:

  (require 'undo-tree)

to your .emacs file. Byte-compiling undo-tree.el is recommended (e.g. using
"M-x byte-compile-file" from within emacs).

If you want to replace the standard Emacs' undo system with the
`undo-tree-mode' system in all buffers, you can enable it globally by
adding:

  (global-undo-tree-mode)

to your .emacs file.


Quick-Start
===========

If you're the kind of person who likes to jump in the car and drive,
without bothering to first figure out whether the button on the left dips
the headlights or operates the ejector seat (after all, you'll soon figure
it out when you push it), then here's the minimum you need to know:

`undo-tree-mode' and `global-undo-tree-mode'
  Enable undo-tree mode (either in the current buffer or globally).

C-_  C-/  (`undo-tree-undo')
  Undo changes.

M-_  C-?  (`undo-tree-redo')
  Redo changes.

`undo-tree-switch-branch'
  Switch undo-tree branch.
  (What does this mean? Better press the button and see!)

C-x u  (`undo-tree-visualize')
  Visualize the undo tree.
  (Better try pressing this button too!)

C-x r u  (`undo-tree-save-state-to-register')
  Save current buffer state to register.

C-x r U  (`undo-tree-restore-state-from-register')
  Restore buffer state from register.



In the undo-tree visualizer:

<up>  p  C-p  (`undo-tree-visualize-undo')
  Undo changes.

<down>  n  C-n  (`undo-tree-visualize-redo')
  Redo changes.

<left>  b  C-b  (`undo-tree-visualize-switch-branch-left')
  Switch to previous undo-tree branch.

<right>  f  C-f  (`undo-tree-visualize-switch-branch-right')
  Switch to next undo-tree branch.

C-<up>  M-{  (`undo-tree-visualize-undo-to-x')
  Undo changes up to last branch point.

C-<down>  M-}  (`undo-tree-visualize-redo-to-x')
  Redo changes down to next branch point.

<down>  n  C-n  (`undo-tree-visualize-redo')
  Redo changes.

<mouse-1>  (`undo-tree-visualizer-mouse-set')
  Set state to node at mouse click.

t  (`undo-tree-visualizer-toggle-timestamps')
  Toggle display of time-stamps.

d  (`undo-tree-visualizer-toggle-diff')
  Toggle diff display.

s  (`undo-tree-visualizer-selection-mode')
  Toggle keyboard selection mode.

q  (`undo-tree-visualizer-quit')
  Quit undo-tree-visualizer.

C-q  (`undo-tree-visualizer-abort')
  Abort undo-tree-visualizer.

,  <
  Scroll left.

.  >
  Scroll right.

<pgup>  M-v
  Scroll up.

<pgdown>  C-v
  Scroll down.



In visualizer selection mode:

<up>  p  C-p  (`undo-tree-visualizer-select-previous')
  Select previous node.

<down>  n  C-n  (`undo-tree-visualizer-select-next')
  Select next node.

<left>  b  C-b  (`undo-tree-visualizer-select-left')
  Select left sibling node.

<right>  f  C-f  (`undo-tree-visualizer-select-right')
  Select right sibling node.

<pgup>  M-v
  Select node 10 above.

<pgdown>  C-v
  Select node 10 below.

<enter>  (`undo-tree-visualizer-set')
  Set state to selected node and exit selection mode.

s  (`undo-tree-visualizer-mode')
  Exit selection mode.

t  (`undo-tree-visualizer-toggle-timestamps')
  Toggle display of time-stamps.

d  (`undo-tree-visualizer-toggle-diff')
  Toggle diff display.

q  (`undo-tree-visualizer-quit')
  Quit undo-tree-visualizer.

C-q  (`undo-tree-visualizer-abort')
  Abort undo-tree-visualizer.

,  <
  Scroll left.

.  >
  Scroll right.



Persistent undo history:

Note: Requires a recent development version of Emacs checked out out from
      the Emacs bzr repository. All stable versions of Emacs currently
      break this feature.

`undo-tree-auto-save-history' (variable)
   automatically save and restore undo-tree history along with buffer
   (disabled by default)

`undo-tree-save-history' (command)
   manually save undo history to file

`undo-tree-load-history' (command)
   manually load undo history from file



Compressing undo history:

  Undo history files cannot grow beyond the maximum undo tree size, which
  is limited by `undo-limit', `undo-strong-limit' and
  `undo-outer-limit'. Nevertheless, undo history files can grow quite
  large. If you want to automatically compress undo history, add the
  following advice to your .emacs file (replacing ".gz" with the filename
  extension of your favourite compression algorithm):

  (defadvice undo-tree-make-history-save-file-name
    (after undo-tree activate)
    (setq concat ad-return-value ".gz"))




Undo Systems
============

To understand the different undo systems, it's easiest to consider an
example. Imagine you make a few edits in a buffer. As you edit, you
accumulate a history of changes, which we might visualize as a string of
past buffer states, growing downwards:

                               o  (initial buffer state)
                               |
                               |
                               o  (first edit)
                               |
                               |
                               o  (second edit)
                               |
                               |
                               x  (current buffer state)


Now imagine that you undo the last two changes. We can visualize this as
rewinding the current state back two steps:

                               o  (initial buffer state)
                               |
                               |
                               x  (current buffer state)
                               |
                               |
                               o
                               |
                               |
                               o


However, this isn't a good representation of what Emacs' undo system
does. Instead, it treats the undos as *new* changes to the buffer, and adds
them to the history:

                               o  (initial buffer state)
                               |
                               |
                               o  (first edit)
                               |
                               |
                               o  (second edit)
                               |
                               |
                               x  (buffer state before undo)
                               |
                               |
                               o  (first undo)
                               |
                               |
                               x  (second undo)


Actually, since the buffer returns to a previous state after an undo,
perhaps a better way to visualize it is to imagine the string of changes
turning back on itself:

       (initial buffer state)  o
                               |
                               |
                 (first edit)  o  x  (second undo)
                               |  |
                               |  |
                (second edit)  o  o  (first undo)
                               | /
                               |/
                               o  (buffer state before undo)

Treating undos as new changes might seem a strange thing to do. But the
advantage becomes clear as soon as we imagine what happens when you edit
the buffer again. Since you've undone a couple of changes, new edits will
branch off from the buffer state that you've rewound to. Conceptually, it
looks like this:

                               o  (initial buffer state)
                               |
                               |
                               o
                               |\
                               | \
                               o  x  (new edit)
                               |
                               |
                               o

The standard undo/redo system only lets you go backwards and forwards
linearly. So as soon as you make that new edit, it discards the old
branch. Emacs' undo just keeps adding changes to the end of the string. So
the undo history in the two systems now looks like this:

           Undo/Redo:                      Emacs' undo

              o                                o
              |                                |
              |                                |
              o                                o  o
              .\                               |  |\
              . \                              |  | \
              .  x  (new edit)                 o  o  |
  (discarded  .                                | /   |
    branch)   .                                |/    |
              .                                o     |
                                                     |
                                                     |
                                                     x  (new edit)

Now, what if you change your mind about those undos, and decide you did
like those other changes you'd made after all? With the standard undo/redo
system, you're lost. There's no way to recover them, because that branch
was discarded when you made the new edit.

However, in Emacs' undo system, those old buffer states are still there in
the undo history. You just have to rewind back through the new edit, and
back through the changes made by the undos, until you reach them. Of
course, since Emacs treats undos (even undos of undos!) as new changes,
you're really weaving backwards and forwards through the history, all the
time adding new changes to the end of the string as you go:

                      o
                      |
                      |
                      o  o     o  (undo new edit)
                      |  |\    |\
                      |  | \   | \
                      o  o  |  |  o  (undo the undo)
                      | /   |  |  |
                      |/    |  |  |
     (trying to get   o     |  |  x  (undo the undo)
      to this state)        | /
                            |/
                            o

So far, this is still reasonably intuitive to use. It doesn't behave so
differently to standard undo/redo, except that by going back far enough you
can access changes that would be lost in standard undo/redo.

However, imagine that after undoing as just described, you decide you
actually want to rewind right back to the initial state. If you're lucky,
and haven't invoked any command since the last undo, you can just keep on
undoing until you get back to the start:

     (trying to get   o              x  (got there!)
      to this state)  |              |
                      |              |
                      o  o     o     o  (keep undoing)
                      |  |\    |\    |
                      |  | \   | \   |
                      o  o  |  |  o  o  (keep undoing)
                      | /   |  |  | /
                      |/    |  |  |/
     (already undid   o     |  |  o  (got this far)
      to this state)        | /
                            |/
                            o

But if you're unlucky, and you happen to have moved the point (say) after
getting to the state labelled "got this far", then you've "broken the undo
chain". Hold on to something solid, because things are about to get
hairy. If you try to undo now, Emacs thinks you're trying to undo the
undos! So to get back to the initial state you now have to rewind through
*all* the changes, including the undos you just did:

     (trying to get   o                          x  (finally got there!)
      to this state)  |                          |
                      |                          |
                      o  o     o     o     o     o
                      |  |\    |\    |\    |\    |
                      |  | \   | \   | \   | \   |
                      o  o  |  |  o  o  o  |  o  o
                      | /   |  |  | /   |  |  | /
                      |/    |  |  |/    |  |  |/
     (already undid   o     |  |  o<.   |  |  o
      to this state)        | /     :   | /
                            |/      :   |/
                            o       :   o
                                    :
                            (got this far, but
                             broke the undo chain)

Confused?

In practice you can just hold down the undo key until you reach the buffer
state that you want. But whatever you do, don't move around in the buffer
to *check* that you've got back to where you want! Because you'll break the
undo chain, and then you'll have to traverse the entire string of undos
again, just to get back to the point at which you broke the
chain. Undo-in-region and commands such as `undo-only' help to make using
Emacs' undo a little easier, but nonetheless it remains confusing for many
people.


So what does `undo-tree-mode' do? Remember the diagram we drew to represent
the history we've been discussing (make a few edits, undo a couple of them,
and edit again)? The diagram that conceptually represented our undo
history, before we started discussing specific undo systems? It looked like
this:

                               o  (initial buffer state)
                               |
                               |
                               o
                               |\
                               | \
                               o  x  (current state)
                               |
                               |
                               o

Well, that's *exactly* what the undo history looks like to
`undo-tree-mode'.  It doesn't discard the old branch (as standard undo/redo
does), nor does it treat undos as new changes to be added to the end of a
linear string of buffer states (as Emacs' undo does). It just keeps track
of the tree of branching changes that make up the entire undo history.

If you undo from this point, you'll rewind back up the tree to the previous
state:

                               o
                               |
                               |
                               x  (undo)
                               |\
                               | \
                               o  o
                               |
                               |
                               o

If you were to undo again, you'd rewind back to the initial state. If on
the other hand you redo the change, you'll end up back at the bottom of the
most recent branch:

                               o  (undo takes you here)
                               |
                               |
                               o  (start here)
                               |\
                               | \
                               o  x  (redo takes you here)
                               |
                               |
                               o

So far, this is just like the standard undo/redo system. But what if you
want to return to a buffer state located on a previous branch of the
history? Since `undo-tree-mode' keeps the entire history, you simply need
to tell it to switch to a different branch, and then redo the changes you
want:

                               o
                               |
                               |
                               o  (start here, but switch
                               |\  to the other branch)
                               | \
                       (redo)  o  o
                               |
                               |
                       (redo)  x

Now you're on the other branch, if you undo and redo changes you'll stay on
that branch, moving up and down through the buffer states located on that
branch. Until you decide to switch branches again, of course.

Real undo trees might have multiple branches and sub-branches:

                               o
                           ____|______
                          /           \
                         o             o
                     ____|__         __|
                    /    |  \       /   \
                   o     o   o     o     x
                   |               |
                  / \             / \
                 o   o           o   o

Trying to imagine what Emacs' undo would do as you move about such a tree
will likely frazzle your brain circuits! But in `undo-tree-mode', you're
just moving around this undo history tree. Most of the time, you'll
probably only need to stay on the most recent branch, in which case it
behaves like standard undo/redo, and is just as simple to understand. But
if you ever need to recover a buffer state on a different branch, the
possibility of switching between branches and accessing the full undo
history is still there.



The Undo-Tree Visualizer
========================

Actually, it gets better. You don't have to imagine all these tree
diagrams, because `undo-tree-mode' includes an undo-tree visualizer which
draws them for you! In fact, it draws even better diagrams: it highlights
the node representing the current buffer state, it highlights the current
branch, and you can toggle the display of time-stamps (by hitting "t") and
a diff of the undo changes (by hitting "d"). (There's one other tiny
difference: the visualizer puts the most recent branch on the left rather
than the right.)

Bring up the undo tree visualizer whenever you want by hitting "C-x u".

In the visualizer, the usual keys for moving up and down a buffer instead
move up and down the undo history tree (e.g. the up and down arrow keys, or
"C-n" and "C-p"). The state of the "parent" buffer (the buffer whose undo
history you are visualizing) is updated as you move around the undo tree in
the visualizer. If you reach a branch point in the visualizer, the usual
keys for moving forward and backward in a buffer instead switch branch
(e.g. the left and right arrow keys, or "C-f" and "C-b").

Clicking with the mouse on any node in the visualizer will take you
directly to that node, resetting the state of the parent buffer to the
state represented by that node.

You can also select nodes directly using the keyboard, by hitting "s" to
toggle selection mode. The usual motion keys now allow you to move around
the tree without changing the parent buffer. Hitting <enter> will reset the
state of the parent buffer to the state represented by the currently
selected node.

It can be useful to see how long ago the parent buffer was in the state
represented by a particular node in the visualizer. Hitting "t" in the
visualizer toggles the display of time-stamps for all the nodes. (Note
that, because of the way `undo-tree-mode' works, these time-stamps may be
somewhat later than the true times, especially if it's been a long time
since you last undid any changes.)

To get some idea of what changes are represented by a given node in the
tree, it can be useful to see a diff of the changes. Hit "d" in the
visualizer to toggle a diff display. This normally displays a diff between
the current state and the previous one, i.e. it shows you the changes that
will be applied if you undo (move up the tree). However, the diff display
really comes into its own in the visualizer's selection mode (see above),
where it instead shows a diff between the current state and the currently
selected state, i.e. it shows you the changes that will be applied if you
reset to the selected state.

(Note that the diff is generated by the Emacs `diff' command, and is
displayed using `diff-mode'. See the corresponding customization groups if
you want to customize the diff display.)

Finally, hitting "q" will quit the visualizer, leaving the parent buffer in
whatever state you ended at. Hitting "C-q" will abort the visualizer,
returning the parent buffer to whatever state it was originally in when the
visualizer was .



Undo-in-Region
==============

Emacs allows a very useful and powerful method of undoing only selected
changes: when a region is active, only changes that affect the text within
that region will be undone. With the standard Emacs undo system, changes
produced by undoing-in-region naturally get added onto the end of the
linear undo history:

                      o
                      |
                      |  x  (second undo-in-region)
                      o  |
                      |  |
                      |  o  (first undo-in-region)
                      o  |
                      | /
                      |/
                      o

You can of course redo these undos-in-region as usual, by undoing the
undos:

                      o
                      |
                      |  o_
                      o  | \
                      |  |  |
                      |  o  o  (undo the undo-in-region)
                      o  |  |
                      | /   |
                      |/    |
                      o     x  (undo the undo-in-region)


In `undo-tree-mode', undo-in-region works similarly: when there's an active
region, undoing only undoes changes that affect that region. However, the
way these undos-in-region are recorded in the undo history is quite
different. In `undo-tree-mode', undo-in-region creates a new branch in the
undo history. The new branch consists of an undo step that undoes some of
the changes that affect the current region, and another step that undoes
the remaining changes needed to rejoin the previous undo history.

     Previous undo history                Undo-in-region

              o                                o
              |                                |
              |                                |
              o                                o
              |                                |\
              |                                | \
              o                                o  x  (undo-in-region)
              |                                |  |
              |                                |  |
              x                                o  o

As long as you don't change the active region after undoing-in-region,
continuing to undo-in-region extends the new branch, pulling more changes
that affect the current region into an undo step immediately above your
current location in the undo tree, and pushing the point at which the new
branch is attached further up the tree:

     First undo-in-region                 Second undo-in-region

              o                                o
              |                                |\
              |                                | \
              o                                o  x  (undo-in-region)
              |\                               |  |
              | \                              |  |
              o  x                             o  o
              |  |                             |  |
              |  |                             |  |
              o  o                             o  o

Redoing takes you back down the undo tree, as usual (as long as you haven't
changed the active region after undoing-in-region, it doesn't matter if it
is still active):

                      o
			 |\
			 | \
			 o  o
			 |  |
			 |  |
			 o  o  (redo)
			 |  |
			 |  |
			 o  x  (redo)


What about redo-in-region? Obviously, this only makes sense if you have
already undone some changes, so that there are some changes to redo!
Redoing-in-region splits off a new branch of the undo history below your
current location in the undo tree. This time, the new branch consists of a
redo step that redoes some of the redo changes that affect the current
region, followed by all the remaining redo changes.

     Previous undo history                Redo-in-region

              o                                o
              |                                |
              |                                |
              x                                o
              |                                |\
              |                                | \
              o                                o  x  (redo-in-region)
              |                                |  |
              |                                |  |
              o                                o  o

As long as you don't change the active region after redoing-in-region,
continuing to redo-in-region extends the new branch, pulling more redo
changes into a redo step immediately below your current location in the
undo tree.

     First redo-in-region                 Second redo-in-region

         o                                     o
         |                                     |
         |                                     |
         o                                     o
         |\                                    |\
         | \                                   | \
         o  x  (redo-in-region)                o  o
         |  |                                  |  |
         |  |                                  |  |
         o  o                                  o  x  (redo-in-region)
                                                  |
                                                  |
                                                  o

Note that undo-in-region and redo-in-region only ever add new changes to
the undo tree, they *never* modify existing undo history. So you can always
return to previous buffer states by switching to a previous branch of the
tree.
