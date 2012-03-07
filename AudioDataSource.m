//
//  AudioDataSource.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 3/6/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "AudioDataSource.h"

@implementation AudioDataSource
@synthesize tableSet;

- (id)init
{
	if (nil == (self = [super init])) {
		return nil;
	}
	tableSet = [[NSMutableArray alloc] init];
	return self;
}

- (void)setTableSet:(id)newSet
{
	if (newSet) {
		[tableSet release];
		tableSet = [newSet retain];
	}
}

- (NSView *)tableView:(NSTableView *)tableView 
   viewForTableColumn:(NSTableColumn *)tableColumn 
				  row:(NSInteger)row
{
	NSTableCellView *result;
	NSDictionary *userRecords;
	
	ATAudioCell *cell = [tableView makeViewWithIdentifier:[ATAudioCell cellID] owner:self];
	if (!cell ) {
		cell = [[[ATAudioCell cell] retain] autorelease];
	}
	userRecords = [tableSet objectAtIndex:row];
	cell.artist.stringValue = [userRecords objectForKey:ARTIST];
	cell.title.stringValue = [userRecords objectForKey:TITLE];
	cell.duration.stringValue = [userRecords objectForKey:DURATION];
	result = cell;
	
	return result;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
	CGFloat height;
	height = 70.0f;
	return height;
}

- (NSUInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [tableSet count];
}

- (void) dealloc {
	[tableSet release];
	[super dealloc];
}

@end
