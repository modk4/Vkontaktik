//
//  ATNewsCellTwo5.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/12/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//
//	Video as Image

#import "ATNewsCellTwo5.h"

@implementation ATNewsCellTwo5
@synthesize name, timeMessage;//, message;
@synthesize pic, attachments;
@synthesize groupName, groupPic;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATNewsCellTwo5*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"ATNewsCellTwo5" bundle:nil];
    NSArray *objects = nil;
    
    ATNewsCellTwo5* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"ATNewsCellTwo5" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"ATNewsCellTwo5"; }

- (void)dealloc {
    [name release];
    [timeMessage release];
//	[message release];
	[pic release]; // !!!
	[groupName release];
	[groupPic release];
	[attachments release];
	[_reusableIdentifier release];
    [super dealloc];
}
@end
