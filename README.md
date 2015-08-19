vimrc
=====

Plugins
=====
* Vundle (vimscript)
* YAFIA (vimscript)
* EasyTags (vimscript)
* AutoIndentCop (python)

General Programming Support
=====
* <kbd>&lt;leader&gt;ic</kbd> - run autoindentcop on the currently open file
* <kbd>&lt;leader&gt;si</kbd> - run YAIFA to set your indent options to match the current file
* <kbd>&lt;leader&gt;&lt;space&gt;</kbd> - Remove all trailing whitespace from the current file
* <kbd>F2</kbd> - Toggles paste mode

Perl Support
=====
Note: These options are enabled only if the filetype is perl

* <kbd>&lt;leader&gt;t</kbd> - Calls perltidy on visual block selected or entire file if no visual block. Adjusts perltidy options taking into account current expandtab and tabstop settings of vim
* <kbd>&lt;leader&gt;h</kbd> - Calls perldoc. On a 'use' or 'require' line calls module doc, or on a perl function, call appropriate function doc. On a special variable name, calls variable docs up.

HTML Support
=====
Note: these options are enabled only if the filetype is html
* <kbd>&lt;leader&gt;t</kbd> - Calls the `tidy` program on the entire html file

Javscript Support
=====
Note: these options are enabled only if the filetype is javascript

Coming soon.
