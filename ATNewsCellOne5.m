//
//  ATNewsCellOne5.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import "ATNewsCellOne5.h"

@implementation ATNewsCellOne5
@synthesize name, timeMessage;//, message;
@synthesize pic, attachments;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellOne5*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne5" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne5* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne5" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne5"; }

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
