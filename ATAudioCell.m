//
//  ATAudioCell.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/3/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATAudioCell.h"

@implementation ATAudioCell

@synthesize artist, title, duration;
@synthesize play;
@synthesize reusableIdentifier = _reusableIdentifier;

+(ATAudioCell*) cell {
	NSNib *cellNib = [[NSNib alloc] initWithNibNamed:@"AudioCell" bundle:nil];
    NSArray *objects = nil;
    
    ATAudioCell* cell = nil;
    
    [cellNib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:[self class]]) {
            cell = object;
            cell.reusableIdentifier = [@"audioCell" copy];
            break;
        }
    }
    
    [cellNib release];
    
    return cell;
}

+(NSString*) cellID { return @"audioCell"; }

- (void)dealloc {
    [artist release];
    [title release];
	[duration release];
	[play release];
	[_reusableIdentifier release];
    [super dealloc];
}

@end
