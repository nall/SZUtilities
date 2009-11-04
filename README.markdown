## SZURLConnection ##
NSURLConnection is very useful, but it can buffer data coming in from the 
network and this can be undesirable in some applications.  SZURLConnection
is meant to be a drop-in replacement for basic NSURLConnection functionality.
It supports a similar delegate methodology to NSURLConnection.

Limitations:
SZURLConnection does not support caching or authorization delegate methods.

## SZOverlayWindow ##
This is an NSWindow subclass designed to be used as an NSWindow child window.
It's usage is described in [this blog post]
(http://blog.stuntaz.org/2009/11/03/nswindow-overlay.html)
