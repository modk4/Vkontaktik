//
//  ATNewsCellTwo8.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATNewsCellTwo8.h"

@implementation ATNewsCellTwo8
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
//@synthesize artist, title, duration;
//@synthesize play;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;
@synthesize wall = _wall;

+(ATNewsCellTwo8*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo8" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo8* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo8" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo8"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
	[message release];
	[pic release]; // !!!
	[groupName release];
	[groupPic release];
	[attachments release];
//	[artist release];
//  [title release];
//	[duration release];
//	[play release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
