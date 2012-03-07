//
//  ATNewsCellOne3.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellOne3.h"

@implementation ATNewsCellOne3
@synthesize name, timeMessage;//, message;
@synthesize pic, attachments;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellOne3*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne3" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne3* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne3" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne3"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
//	[message release];
	[pic release]; // !!!
	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
