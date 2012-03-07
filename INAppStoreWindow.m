//
//  INAppStoreWindow.m
//
//  Copyright 2011 Indragie Karunaratne. All rights reserved.
//
//  Licensed under the BSD License <http://www.opensource.org/licenses/bsd-license>
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
//  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
//  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
//  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "INAppStoreWindow.h"

#define IN_RUNNING_LION (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6)
#define IN_COMPILING_LION __MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

/** -----------------------------------------
 - There are 2 sets of colors, one for an active (key) state and one for an inactivate state
 - Each set contains 3 colors. 2 colors for the start and end of the title gradient, and another color to draw the separator line on the bottom
 - These colors are meant to mimic the color of the default titlebar (taken from OS X 10.6), but are subject
 to change at any time
 ----------------------------------------- **/

#define IN_COLOR_MAIN_START [NSColor colorWithDeviceWhite:0.659 alpha:1.0]
#define IN_COLOR_MAIN_END [NSColor colorWithDeviceWhite:0.812 alpha:1.0]
#define IN_COLOR_MAIN_BOTTOM [NSColor colorWithDeviceWhite:0.318 alpha:1.0]

#define IN_COLOR_NOTMAIN_START [NSColor colorWithDeviceWhite:0.851 alpha:1.0]
#define IN_COLOR_NOTMAIN_END [NSColor colorWithDeviceWhite:0.929 alpha:1.0]
#define IN_COLOR_NOTMAIN_BOTTOM [NSColor colorWithDeviceWhite:0.600 alpha:1.0]

/** Lion */

#define IN_COLOR_MAIN_START_L [NSColor colorWithDeviceWhite:0.66 alpha:1.0]
#define IN_COLOR_MAIN_END_L [NSColor colorWithDeviceWhite:0.9 alpha:1.0]
#define IN_COLOR_MAIN_BOTTOM_L [NSColor colorWithDeviceWhite:0.408 alpha:1.0]

#define IN_COLOR_NOTMAIN_START_L [NSColor colorWithDeviceWhite:0.878 alpha:1.0]
#define IN_COLOR_NOTMAIN_END_L [NSColor colorWithDeviceWhite:0.976 alpha:1.0]
#define IN_COLOR_NOTMAIN_BOTTOM_L [NSColor colorWithDeviceWhite:0.655 alpha:1.0]

#define TITLEHEIGHT 48

/** Corner clipping radius **/
const CGFloat INCornerClipRadius = 4.0;
const CGFloat INButtonTopOffset = 3.0;

NS_INLINE CGFloat INMidHeight(NSRect aRect) {
    return (aRect.size.height * (CGFloat)0.5);
}

@interface INAppStoreWindow ()
@property (INAppStoreWindowCopy) NSString *windowMenuTitle;
- (void)_doInitialWindowSetup;
- (void)_createTitlebarView;
- (void)_setupTrafficLightsTrackingArea;
- (void)_recalculateFrameForTitleBarView;
- (void)_layoutTrafficLightsAndContent;
- (void)_displayWindowAndTitlebar;
- (CGFloat)_trafficLightSeparation;
@end

@implementation INTitlebarView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		// NSLog(@"Init frame INTitlebarView");
		NSBundle *mainBundle;
		NSString *path;
		mainBundle = [NSBundle mainBundle];
		path = [mainBundle pathForResource:@"head" ofType:@"png"];
		titleImage = [[NSImage alloc] initByReferencingFile:path];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    BOOL drawsAsMainWindow = ([[self window] isMainWindow] && [[NSApplication sharedApplication] isActive]);
    NSRect drawingRect = [self bounds];

    [[self clippingPathWithRect:drawingRect cornerRadius:INCornerClipRadius] addClip];
	[titleImage drawInRect:drawingRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    
    NSColor *bottomColor = nil;
    if (IN_RUNNING_LION) {
        bottomColor = drawsAsMainWindow ? IN_COLOR_MAIN_BOTTOM_L : IN_COLOR_NOTMAIN_BOTTOM_L;
    } else {
        bottomColor = drawsAsMainWindow ? IN_COLOR_MAIN_BOTTOM : IN_COLOR_NOTMAIN_BOTTOM;
    }
    NSRect bottomRect = NSMakeRect(0.0, NSMinY(drawingRect), NSWidth(drawingRect), 1.0);
    [bottomColor set];
    NSRectFill(bottomRect);
    
    if (IN_RUNNING_LION) {
        bottomRect.origin.y += 1.0;
        [[NSColor colorWithDeviceWhite:1.0 alpha:0.12] setFill];
        [[NSBezierPath bezierPathWithRect:bottomRect] fill];
    }
}

// Uses code from NSBezierPath+PXRoundedRectangleAdditions by Andy Matuschak
// <http://code.andymatuschak.org/pixen/trunk/NSBezierPath+PXRoundedRectangleAdditions.m>

- (NSBezierPath*)clippingPathWithRect:(NSRect)aRect cornerRadius:(CGFloat)radius
{
    NSBezierPath *path = [NSBezierPath bezierPath];
	NSRect rect = NSInsetRect(aRect, radius, radius);
    NSPoint cornerPoint = NSMakePoint(NSMinX(aRect), NSMinY(aRect));
    // Create a rounded rectangle path, omitting the bottom left/right corners
    [path appendBezierPathWithPoints:&cornerPoint count:1];
    cornerPoint = NSMakePoint(NSMaxX(aRect), NSMinY(aRect));
    [path appendBezierPathWithPoints:&cornerPoint count:1];
    [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMaxY(rect)) radius:radius startAngle:  0.0 endAngle: 90.0];
    [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMaxY(rect)) radius:radius startAngle: 90.0 endAngle:180.0];
    [path closePath];
    return path;
}

- (void)mouseUp:(NSEvent *)theEvent 
{
    if ([theEvent clickCount] == 2) {
        // Get settings from "System Preferences" >  "Appearance" > "Double-click on windows title bar to minimize"
        NSString *const MDAppleMiniaturizeOnDoubleClickKey = @"AppleMiniaturizeOnDoubleClick";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults addSuiteNamed:NSGlobalDomain];
        BOOL shouldMiniaturize = [[userDefaults objectForKey:MDAppleMiniaturizeOnDoubleClickKey] boolValue];
        if (shouldMiniaturize) {
            [[self window] miniaturize:self];
        }
    }
}

@end

@implementation INAppStoreWindow
@synthesize windowMenuTitle = _windowMenuTitle;

#pragma mark -
#pragma mark Initialization

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    if ((self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag])) {
        [self _doInitialWindowSetup];
    }
    return self;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen
{
    if ((self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag screen:screen])) {
        [self _doInitialWindowSetup];
    }
    return self;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    #if !__has_feature(objc_arc)
    [_titleBarView release];
	[_windowMenuTitle release];
	[titleLabel release];
    [super dealloc];    
    #endif
}

#pragma mark -
#pragma mark NSWindow Overrides

// Disable window titles

- (NSString*)title
{
    return @"Vkontaktik";
}

- (void)setTitle:(NSString*)title
{
	self.windowMenuTitle = title;
	if ( ![self isExcludedFromWindowsMenu] )
		[NSApp changeWindowsItem:self title:self.windowMenuTitle filename:NO];
}

- (void)setRepresentedURL:(NSURL *)url
{
	// do nothing, don't want to show document icon in menu bar
}

- (void)makeKeyAndOrderFront:(id)sender
{
	[super makeKeyAndOrderFront:sender];
	if (![self isExcludedFromWindowsMenu]) {
		[NSApp addWindowsItem:self title:self.windowMenuTitle filename:NO];	
    }
}

- (void)becomeKeyWindow
{
    [super becomeKeyWindow];
    [_titleBarView setNeedsDisplay:YES];
}

- (void)resignKeyWindow
{
    [super resignKeyWindow];
    [_titleBarView setNeedsDisplay:YES];
}

- (void)orderFront:(id)sender
{
	[super orderFront:sender];
	if (![self isExcludedFromWindowsMenu]) {
		[NSApp addWindowsItem:self title:self.windowMenuTitle filename:NO];
    }
}

- (void)orderOut:(id)sender
{
	[super orderOut:sender];
	[NSApp removeWindowsItem:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setTitleBarView:(NSView *)newTitleBarView
{
    if ((_titleBarView != newTitleBarView) && newTitleBarView) {
        [_titleBarView removeFromSuperview];
        #if __has_feature(objc_arc)
        _titleBarView = newTitleBarView;
        #else
        [_titleBarView release];
        _titleBarView = [newTitleBarView retain];
        #endif
        // Configure the view properties and add it as a subview of the theme frame
        NSView *themeFrame = [[self contentView] superview];
        NSView *firstSubview = [[themeFrame subviews] objectAtIndex:0];
        [_titleBarView setAutoresizingMask:(NSViewMinYMargin | NSViewWidthSizable)];
        [self _recalculateFrameForTitleBarView];
        [themeFrame addSubview:_titleBarView positioned:NSWindowBelow relativeTo:firstSubview];
		
		NSRect titleFrame = [_titleBarView frame];
		titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height - 14)];
		[titleLabel setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
		[titleLabel setAlignment:NSCenterTextAlignment];
		[titleLabel setTextColor:[NSColor whiteColor]];
		[titleLabel setDrawsBackground:NO];
		[titleLabel setBordered:NO];
		[titleLabel setEditable:NO];
		[titleLabel setStringValue:@"Вконтактик"];
		[themeFrame addSubview:titleLabel positioned:NSWindowBelow relativeTo:firstSubview];
		
        [self _layoutTrafficLightsAndContent];
        [self _displayWindowAndTitlebar];
    }
}

- (NSView *)titleBarView
{
    return _titleBarView;
}

#pragma mark -
#pragma mark Private

- (void)_doInitialWindowSetup
{
    [self setMovableByWindowBackground:YES];
    /** -----------------------------------------
     - The window automatically does layout every time its moved or resized, which means that the traffic lights and content view get reset at the original positions, so we need to put them back in place
     - NSWindow is hardcoded to redraw the traffic lights in a specific rect, so when they are moved down, only part of the buttons get redrawn, causing graphical artifacts. Therefore, the window must be force redrawn every time it becomes key/resigns key
     ----------------------------------------- **/
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(_layoutTrafficLightsAndContent) name:NSWindowDidResizeNotification object:self];
    [nc addObserver:self selector:@selector(_layoutTrafficLightsAndContent) name:NSWindowDidMoveNotification object:self];
    [nc addObserver:self selector:@selector(_displayWindowAndTitlebar) name:NSWindowDidResignKeyNotification object:self];
    [nc addObserver:self selector:@selector(_displayWindowAndTitlebar) name:NSWindowDidBecomeKeyNotification object:self];
    [nc addObserver:self selector:@selector(_setupTrafficLightsTrackingArea) name:NSWindowDidBecomeKeyNotification object:self];
    [nc addObserver:self selector:@selector(_displayWindowAndTitlebar) name:NSApplicationDidBecomeActiveNotification object:nil];
    [nc addObserver:self selector:@selector(_displayWindowAndTitlebar) name:NSApplicationDidResignActiveNotification object:nil];
    #if IN_COMPILING_LION
    if (IN_RUNNING_LION) {
        [nc addObserver:self selector:@selector(_setupTrafficLightsTrackingArea) name:NSWindowDidExitFullScreenNotification object:nil];
    }
    #endif
    [self _createTitlebarView];
    [self _layoutTrafficLightsAndContent];
    [self _setupTrafficLightsTrackingArea];
}

- (void)_layoutTrafficLightsAndContent
{
    NSButton *close = [self standardWindowButton:NSWindowCloseButton];
    NSButton *minimize = [self standardWindowButton:NSWindowMiniaturizeButton];
    NSButton *zoom = [self standardWindowButton:NSWindowZoomButton];
	[zoom setHidden:YES];
    
    // Set the frame of the window buttons
    NSRect closeFrame = [close frame];
    NSRect minimizeFrame = [minimize frame];
    NSRect titleBarFrame = [_titleBarView frame];
    CGFloat buttonOrigin = 0.0;
    buttonOrigin = round(NSMidY(titleBarFrame) - INMidHeight(closeFrame));
	buttonOrigin = buttonOrigin + 2;
    closeFrame.origin.y = buttonOrigin;
    minimizeFrame.origin.y = buttonOrigin;
	closeFrame.origin.x = 7;
    minimizeFrame.origin.x = 7 + [self _trafficLightSeparation];
    [close setFrame:closeFrame];
    [minimize setFrame:minimizeFrame];
    
    // Reposition the content view
    NSView *contentView = [self contentView];    
    NSRect windowFrame = [self frame];
    NSRect newFrame = [contentView frame];
    CGFloat titleHeight = NSHeight(windowFrame) - NSHeight(newFrame);
    CGFloat extraHeight = TITLEHEIGHT - titleHeight;
    newFrame.size.height -= extraHeight;
    [contentView setFrame:newFrame];
    [contentView setNeedsDisplay:YES];
}


- (void)_createTitlebarView
{
    // Create the title bar view
    #if __has_feature(objc_arc)
    self.titleBarView = [[INTitlebarView alloc] initWithFrame:NSZeroRect];
    #else
    self.titleBarView = [[[INTitlebarView alloc] initWithFrame:NSZeroRect] autorelease];
    #endif
}

- (void)_hideTitleBarView:(BOOL)hidden 
{
    [self.titleBarView setHidden:hidden];
}

// Solution for tracking area issue thanks to @Perspx (Alex Rozanski) <https://gist.github.com/972958>
- (void)_setupTrafficLightsTrackingArea
{
    [[[self contentView] superview] viewWillStartLiveResize];
    [[[self contentView] superview] viewDidEndLiveResize];
}

- (void)_recalculateFrameForTitleBarView
{
    NSView *themeFrame = [[self contentView] superview];
    NSRect themeFrameRect = [themeFrame frame];
    NSRect titleFrame = NSMakeRect(0.0, NSMaxY(themeFrameRect) - TITLEHEIGHT, NSWidth(themeFrameRect), TITLEHEIGHT);
    [_titleBarView setFrame:titleFrame];
}

- (CGFloat)_trafficLightSeparation
{
    static CGFloat trafficLightSeparation = 0.0;
    if ( !trafficLightSeparation ) {
        NSButton *close = [self standardWindowButton:NSWindowCloseButton];
        NSButton *minimize = [self standardWindowButton:NSWindowMiniaturizeButton];
        trafficLightSeparation = NSMinX(minimize.frame) - NSMinX(close.frame);
    }
    return trafficLightSeparation;    
}

- (void)_displayWindowAndTitlebar
{
    // Redraw the window and titlebar
    [_titleBarView setNeedsDisplay:YES];
}
@end
