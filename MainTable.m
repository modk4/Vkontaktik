//
//  MainTable.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 3/7/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "MainTable.h"

@implementation MainTable

@synthesize selectedCellRowIndex, selectedCellColumnIndex, customSelectedCell;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		selectedCellRowIndex = [[NSNumber alloc] init];
		selectedCellColumnIndex = [[NSNumber alloc] init];
		customSelectedCell = [[NSCell alloc] init];
    }
    
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    long column = [self columnAtPoint:point];
    long row = [self rowAtPoint:point];
	
    if(column == -1 || row == -1) {
        //This condition avoids selection of a rows/columns beyond the range
    }
    else {
        NSTableColumn* aColumn = [[self tableColumns] objectAtIndex:column];
        NSCell *aCell = [aColumn dataCellForRow:row];
		
        [self setSelectedCellRowIndex:[NSNumber numberWithLong:row]];
        [self setSelectedCellColumnIndex:[NSNumber numberWithLong:column]];
        [self setCustomSelectedCell:aCell];
    }
    [super mouseDown:theEvent];
}

- (void)dealloc {
	[selectedCellRowIndex release];
	[selectedCellColumnIndex release];
	[customSelectedCell release];
    [super dealloc];
}

/*- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}*/

@end
