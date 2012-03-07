//
//  ATNewsCellOne2.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellOne2.h"

@implementation ATNewsCellOne2
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellOne2*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne2" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne2* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne2" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne2"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
