//
//  ATNewsCellOne1.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellOne1.h"

@implementation ATNewsCellOne1
@synthesize name, timeMessage, message;
@synthesize pic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellOne1*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne1" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne1* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne1" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne1"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[_reusableIdentifier release];
    [super dealloc];
}
@end
