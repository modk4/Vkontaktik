//
//  ATNewsCellOne4.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import "ATNewsCellOne4.h"

@implementation ATNewsCellOne4
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellOne4*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne4" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne4* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne4" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne4"; }

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
