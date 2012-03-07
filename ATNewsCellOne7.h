//
//  ATNewsCellOne7.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATNewsCellOne7 : NSTableCellView {
	
	IBOutlet NSTextField *name, *timeMessage;
//	IBOutlet NSTextView *message;
	IBOutlet NSImageView *pic;
//	IBOutlet NSTextField *artist, *title, *duration;
//	IBOutlet NSButton *play;
	
	IBOutlet NSTableView *wall;
	
	NSString *_reusableIdentifier;
}

@property (assign) NSTextField *name, *timeMessage;
//@property (assign) NSTextView *message;
@property (assign) NSImageView *pic;
//@property (assign) NSTextField *artist, *title, *duration;
//@property (assign) NSButton *play;
@property (copy) NSString *reusableIdentifier;
@property (assign) IBOutlet NSTableView *wall;

+(ATNewsCellOne7*)cell;
+(NSString*) cellID;
@end
