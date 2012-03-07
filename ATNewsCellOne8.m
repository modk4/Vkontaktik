//
//  ATNewsCellOne8.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellOne8.h"

@implementation ATNewsCellOne8
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
//@synthesize artist, title, duration;
//@synthesize play;
@synthesize reusableIdentifier = _reusableIdentifier;
@synthesize wall = _wall;

+(ATNewsCellOne8*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne8" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne8* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne8" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne8"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[attachments release];
//	[artist release];
//  [title release];
//	[duration release];
//	[play release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
