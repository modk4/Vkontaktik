//
//  ATNewsCellOne6.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellOne6.h"

@implementation ATNewsCellOne6
@synthesize name, timeMessage, message;
@synthesize pic;
//@synthesize artist, title, duration;
//@synthesize play;
@synthesize reusableIdentifier = _reusableIdentifier;
@synthesize wall = _wall;

+(ATNewsCellOne6*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellOne6" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellOne6* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellOne6" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellOne6"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
//	[artist release];
//    [title release];
//	[duration release];
//	[play release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
