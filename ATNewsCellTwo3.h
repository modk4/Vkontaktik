//
//  ATNewsCellTwo3.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATNewsCellTwo3 : NSTableCellView {
	
	IBOutlet NSTextField *name, *timeMessage;
	//IBOutlet NSTextView *message;
	IBOutlet NSImageView *pic, *attachments;
	IBOutlet NSTextField *groupName;
	IBOutlet NSImageView *groupPic;
	
	NSString *_reusableIdentifier;
	
}

@property (assign) NSTextField *name, *timeMessage;
//@property (assign) NSTextView *message;
@property (assign) NSImageView *pic, *attachments;
@property (copy) NSString *reusableIdentifier;
@property (assign) NSTextField *groupName;
@property (assign) NSImageView *groupPic;

+(ATNewsCellTwo3*)cell;
+(NSString*) cellID;
@end
