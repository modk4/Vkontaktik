//
//  ATNewsCellTwo10.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import "ATNewsCellTwo10.h"

@implementation ATNewsCellTwo10
@synthesize name, timeMessage, message;
@synthesize pic, attachments;
//@synthesize artist, title, duration;
//@synthesize play;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;
@synthesize wall = _wall;

+(ATNewsCellTwo10*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo10" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo10* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo10" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo10"; }

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
