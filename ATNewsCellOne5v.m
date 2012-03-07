//
//  ATNewsCellOne5.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import "ATNewsCellOne5v.h"

@implementation ATNewsCellOne5v
@synthesize name, timeMessage;//, message;
@synthesize pic;//, attachments;
@synthesize reusableIdentifier = _reusableIdentifier;
@synthesize movie;

+(ATNewsCellOne5v*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne5v" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne5v* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne5v" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne5v"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[movie release];
//	[message release];
	[pic release]; // !!!
//	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
