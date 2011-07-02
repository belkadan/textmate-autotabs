# TMAutoTabs #

When you load a new document in TextMate, TMAutoTabs attempts to detect if the document uses spaces or tabs for indentation. If the document uses spaces, TMAutoTabs also guesses the indent size.

To install, download [TMAutoTabs.tmplugin][] to `~/Library/Application Support/TextMate/PlugIns` and relaunch TextMate. (You should create that folder if it doesn't already exist.)

This software may not work perfectly, particularly on projects that prefer spaces to tabs. Bug reports welcome!

  [TMAutoTabs.tmplugin]: https://github.com/downloads/belkadan/textmate-autotabs/TMAutoTabs.tmplugin.zip
  [TextMate]: http://macromates.com/


## Known Issues ##
- In a project, switching back and forth between documents counts as reloading each document...meaning, if you override the autodetection, it doesn't stick.
- No per-document or per-project preferences.


## License ##

 Copyright (c) 2011 Jordy Rose

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

 Except as contained in this notice, the name(s) of the above copyright holders
 shall not be used in advertising or otherwise to promote the sale, use or other
 dealings in this Software without prior authorization.

