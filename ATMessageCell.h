//
//  ATMessageCell.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/4/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATMessageCell : NSTableCellView {

IBOutlet NSTextField *name, *timeMessage, *messageTitle, *unread;
IBOutlet NSTextView *message;
IBOutlet NSImageView *pic;

NSString *_reusableIdentifier;

}

@property (assign) NSTextField *name, *timeMessage, *messageTitle, *unread;
@property (assign) NSTextView *message;
@property (assign) NSImageView *pic;
@property (copy) NSString *reusableIdentifier;

+(ATMessageCell*)cell;
+(NSString*) cellID;

@end
