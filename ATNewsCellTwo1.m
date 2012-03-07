//
//  ATNewsCellTwo1.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellTwo1.h"

@implementation ATNewsCellTwo1
@synthesize name, timeMessage, message;
@synthesize pic;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellTwo1*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo1" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo1* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo1" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo1"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[groupName release];
	[groupPic release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
