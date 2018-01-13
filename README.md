# clean-wrap-guide
An atom package dedicated to striking the perfect compromise between helpful visual noise and an austere clean look.

### The case for this package:
The ergonomic factors of code readiablity include a preferred line length limit. Automatic soft wrap is a nightmare because it hinders the "write first, refactor later" mentality because it wrecks readability immediately. An unusually long line is just a minor annoyance. A wrap guide is a visual cue showing you if cleanup is necessary at a later point.

**The problem:** having a wrap guide visible at all times is distracting visual noise. I'm on a quest to remove all unecessary visual noise from atom, and the wrap guide is undoubtedly unecessary when code is formatted well. This script toggles the visibility of the wrap guide if a line exceeds the preferred line length.

(*…This is really just an exercise in publishing a package for Atom…*)

Here's how it looks:
![clean wrap guide demo](/clean-wrap-showcase.gif)