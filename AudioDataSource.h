//
//  AudioDataSource.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 3/6/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Const.h"
#import "ATAudioCell.h"

@interface AudioDataSource : NSObject {
	NSMutableArray *tableSet;
}
@property (nonatomic, retain) NSMutableArray *tableSet;
@end
