//
//  TableDataSource.h
//  torrent-search
//
//  Created by Andrey Andreev on 3/4/11.
//  Copyright 2011 AndyApps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Const.h"
#import "AudioDataSource.h"
#import "ATAudioCell.h"
#import "ATMessageCell.h"
#import "ATNewsCellOne.h"
#import "ATNewsCellTwo.h"

@interface TableDataSource : NSObject {
	NSMutableArray *tableSet;
	NSUInteger choice;
	//IBOutlet ATAudioCell *audio;
}
@property (nonatomic, retain) NSMutableArray *tableSet;
@property (nonatomic, assign) NSUInteger choice;
//@property (nonatomic, assign) IBOutlet ATAudioCell *audio;
@end
