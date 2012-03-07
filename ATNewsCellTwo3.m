//
//  ATNewsCellTwo3.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellTwo3.h"

@implementation ATNewsCellTwo3
@synthesize name, timeMessage;//, message;
@synthesize pic, attachments;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellTwo3*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo3" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo3* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo3" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo3"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
//	[message release];
	[pic release]; // !!!
	[groupName release];
	[groupPic release];
	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
