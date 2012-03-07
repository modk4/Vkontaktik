//
//  ATNewsCellTwo2.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellTwo2.h"

@implementation ATNewsCellTwo2
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellTwo2*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo2" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo2* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo2" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo2"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[groupName release];
	[groupPic release];
	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
