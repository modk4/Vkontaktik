//
//  SampleAppAppDelegate.h
//  SampleApp
//
//  Created by Andrey Andreev on 2/2/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "INAppStoreWindow.h"
#import "EBVKAPI.h"
#import "Const.h"

#define APP_ID        @"2681452"
#define USER_EMAIL    @"aaa.andreev@gmail.com"
#define USER_PASSWORD @"dulufa67"
//#define USER_EMAIL    @"evgeny@artnewage.ru"
//#define USER_PASSWORD @"080350vk"
//#define USER_EMAIL    @"andropoff"
//#define USER_PASSWORD @"@ndr0pofF6710"

@interface SampleAppAppDelegate : NSObject <NSApplicationDelegate> {
    INAppStoreWindow *_window;
	IBOutlet NSPanel *spinPanel;
	IBOutlet NSProgressIndicator *delayVk;
	IBOutlet NSButton *button1, *button2, *button3, *button4, *button5;
	IBOutlet NSTableView *wall;
	
	IBOutlet NSTextField *friendsCount, *audioCount, *messageCount, *newsCount, *wallCount;
	IBOutlet NSImageView *userPic;
	EBVKAPIToken *token;
	
	NSSound *sound;
	NSButton *currentPlay;
	NSInteger currentSoundRow;
	
	NSMutableArray *friendsArray, *newsArray, *messageArray, *wallArray, *audioArray;
	NSTimer *updateTimer;
}

@property (assign) IBOutlet INAppStoreWindow *window;
@property (assign) IBOutlet NSPanel *spinPanel;
@property (assign) IBOutlet NSProgressIndicator *delayVk;
@property (assign) IBOutlet NSTableView *wall;
@property (assign) IBOutlet NSButton *button1, *button2, *button3, *button4, *button5;
@property (assign) IBOutlet NSTextField *friendsCount, *audioCount, *messageCount, *newsCount, *wallCount;
@property (assign) IBOutlet NSImageView *userPic;
@property (retain) EBVKAPIToken *token;
@property (retain) NSMutableArray *friendsArray, *newsArray, *messageArray, *wallArray, *audioArray;
@property (retain) NSTimer *updateTimer;

- (IBAction) performClick1:(id)sender;
- (IBAction) performClick2:(id)sender;
- (IBAction) performClick3:(id)sender;
- (IBAction) performClick4:(id)sender;
- (IBAction) performClick5:(id)sender;

- (IBAction)btnInCellClicked:(id)sender;
@end
