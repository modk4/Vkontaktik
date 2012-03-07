//
//  ATMessageCell.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/4/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATMessageCell.h"

@implementation ATMessageCell

@synthesize name, timeMessage, messageTitle, message, unread;
@synthesize pic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATMessageCell*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"MessageCell" bundle:nil];
    NSArray *objects = nil;
    
    ATMessageCell* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"messageCell" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"messageCell"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[messageTitle release];
	[pic release]; //!!!
	[_reusableIdentifier release];
    [super dealloc];
}

@end
