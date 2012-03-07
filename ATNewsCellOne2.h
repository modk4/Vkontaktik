//
//  ATNewsCellOne2.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATNewsCellOne2 : NSTableCellView {
	
	IBOutlet NSTextField *name, *timeMessage;
	IBOutlet NSTextView *message;
	IBOutlet NSImageView *pic, *attachments;
	
	NSString *_reusableIdentifier;
	
}

@property (assign) NSTextField *name, *timeMessage;
@property (assign) NSTextView *message;
@property (assign) NSImageView *pic, *attachments;
@property (copy) NSString *reusableIdentifier;

+(ATNewsCellOne2*)cell;
+(NSString*) cellID;
@end
