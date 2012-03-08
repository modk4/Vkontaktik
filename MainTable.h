//
//  MainTable.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 3/7/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainTable : NSTableView {
    NSNumber *selectedCellRowIndex;
    NSNumber *selectedCellColumnIndex;
    NSCell *customSelectedCell;
}

@property (nonatomic, retain) NSNumber *selectedCellRowIndex;
@property (nonatomic, retain) NSNumber *selectedCellColumnIndex;
@property (nonatomic, retain) NSCell *customSelectedCell;

@end
