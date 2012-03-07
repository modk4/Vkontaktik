//
//  ATNewsCellOne5.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import <Cocoa/Cocoa.h>

@interface ATNewsCellOne5 : NSTableCellView {
	
	IBOutlet NSTextField *name, *timeMessage;
//	IBOutlet NSTextView *message;
	IBOutlet NSImageView *pic, *attachments;
	
	NSString *_reusableIdentifier;
	
}

@property (assign) NSTextField *name, *timeMessage;
//@property (assign) NSTextView *message;
@property (assign) NSImageView *pic, *attachments;
@property (copy) NSString *reusableIdentifier;

+(ATNewsCellOne5*)cell;
+(NSString*) cellID;
@end
