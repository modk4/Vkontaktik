//
//  ATAudioCell.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/3/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATAudioCell : NSTableCellView {

IBOutlet NSTextField *artist, *title, *duration;
IBOutlet NSButton *play;
	
NSString *_reusableIdentifier;
	
}

@property (assign) NSTextField *artist, *title, *duration;
@property (assign) NSButton *play;
@property (copy) NSString *reusableIdentifier;

+(ATAudioCell*)cell;
+(NSString*) cellID;

@end