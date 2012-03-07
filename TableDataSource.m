//
//  TableDataSource.m
//  torrent-search
//
//  Created by Andrey Andreev on 3/4/11.
//  Copyright 2011 AndyApps. All rights reserved.
//

#import "TableDataSource.h"


@implementation TableDataSource
@synthesize tableSet;
@synthesize choice;
//@synthesize audio;

- (id)init
{
	if (nil == (self = [super init])) {
		return nil;
	}
	tableSet = [[NSMutableArray alloc] init];
	choice = 0;
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
	id pic = nil;
	
	switch (choice) {
		case kAudio: {
			ATAudioCell *cell = [tableView makeViewWithIdentifier:[ATAudioCell cellID] owner:self];
			if (!cell ) {
				cell = [[[ATAudioCell cell] retain] autorelease];
			}
			userRecords = [tableSet objectAtIndex:row];
			cell.artist.stringValue = [userRecords objectForKey:ARTIST];
			cell.title.stringValue = [userRecords objectForKey:TITLE];
			cell.duration.stringValue = [userRecords objectForKey:DURATION];
			result = cell;
			break;
		}
		
		case kFriends: {
			//NSLog(@"Friends");
			// get an existing cell with the MyView identifier if it exists
			result = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
			userRecords = [tableSet objectAtIndex:row];
			result.textField.stringValue = [userRecords objectForKey:USERNAME];
			pic = [userRecords objectForKey:USERPIC];
			if (pic) {
				result.imageView.image = [userRecords objectForKey:USERPIC];
			}
			break;
		}
		case kMessages: {
			ATMessageCell *cell = [tableView makeViewWithIdentifier:[ATMessageCell cellID] owner:self];
			if (!cell ) {
				cell = [[[ATMessageCell cell] retain] autorelease];
			}
			userRecords = [tableSet objectAtIndex:row];
			NSString *userName = [userRecords objectForKey:USERNAME];
			if (userName) {
				cell.name.stringValue = userName;
			} else cell.name.stringValue = @"Ivan Ivanov?";
			cell.messageTitle.stringValue = [userRecords objectForKey:TITLE];
			
			[cell.message setString:[userRecords objectForKey:MESSAGE]];
			
			cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
			//cell.message.stringValue = [userRecords objectForKey:MESSAGE];
			cell.unread.stringValue = [[userRecords objectForKey:READSTATE] boolValue]? @"":@"⦿";
			pic = [userRecords objectForKey:USERPIC];
			if (pic) {
				cell.pic.image = [userRecords objectForKey:USERPIC];
			}
			result = cell;
			break;
		}
		case kNews: {
			userRecords = [tableSet objectAtIndex:row];
			unsigned int i = [[userRecords objectForKey:@"newsType"] unsignedIntValue];
			
			switch (i) {
				case kNewsType1: {
					ATNewsCellOne1 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne1 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne1 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					result = cell;
					break;
				}
				case kNewsType2: {
					ATNewsCellOne2 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne2 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne2 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsType3: {
					ATNewsCellOne3 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne3 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne3 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsType4: {
					ATNewsCellOne4 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne4 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne4 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					// Video
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsType5: {
					ATNewsCellOne5 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne5 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne5 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					// Video
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsType6: {
					// Audio
					ATNewsCellOne6 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne6 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne6 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsType7: {
					ATNewsCellOne7 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne7 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne7 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsType8: {
					ATNewsCellOne8 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne8 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne8 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsType9: {
					// Video
					ATNewsCellOne9 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne9 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne9 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsType10: {
					// Video
					ATNewsCellOne10 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne10 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne10 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsType11: {
					// Video
					ATNewsCellOne11 *cell = [tableView makeViewWithIdentifier:[ATNewsCellOne11 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellOne11 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
					
				// Group
				case kNewsTypeG1: {
					ATNewsCellTwo1 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo1 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo1 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					result = cell;
					break;
				}
				case kNewsTypeG2: {
					ATNewsCellTwo2 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo2 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo2 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsTypeG3: {
					ATNewsCellTwo3 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo3 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo3 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsTypeG4: {
					ATNewsCellTwo4 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo4 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo4 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					// Video
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsTypeG5: {
					ATNewsCellTwo5 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo5 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo5 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					// Video
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					result = cell;
					break;
				}
				case kNewsTypeG6: {
					// Audio
					ATNewsCellTwo6 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo6 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo6 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsTypeG7: {
					ATNewsCellTwo7 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo7 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo7 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsTypeG8: {
					ATNewsCellTwo8 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo8 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo8 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsTypeG9: {
					// Video
					ATNewsCellTwo9 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo9 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo9 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsTypeG10: {
					// Video
					ATNewsCellTwo10 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo10 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo10 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				case kNewsTypeG11: {
					// Video
					ATNewsCellTwo11 *cell = [tableView makeViewWithIdentifier:[ATNewsCellTwo11 cellID] owner:self];
					if (!cell ) {
						cell = [[[ATNewsCellTwo11 cell] retain] autorelease];
					}
					NSString *userName = [userRecords objectForKey:USERNAME];
					if (userName) {
						cell.name.stringValue = userName;
					} else cell.name.stringValue = @"Ivan Ivanov?";
					
					//[cell.message setString:[userRecords objectForKey:MESSAGE]];
					
					cell.timeMessage.stringValue = [userRecords objectForKey:DATEMESSAGE];
					
					NSString *groupName = [userRecords objectForKey:GROUPNAME];
					if (groupName) {
						cell.groupName.stringValue = groupName;
					} else cell.groupName.stringValue = @"No Name Group?";
					
					NSImage *picGroup = [userRecords objectForKey:GROUPPIC];
					if (picGroup) {
						cell.groupPic.image = [userRecords objectForKey:GROUPPIC];
					}
					
					pic = [userRecords objectForKey:USERPIC];
					if (pic) {
						cell.pic.image = [userRecords objectForKey:USERPIC];
					}
					pic = [userRecords objectForKey:ATTACHMENTSPHOTO];
					if (pic) {
						cell.attachments.image = [userRecords objectForKey:ATTACHMENTSPHOTO];
					}
					NSMutableArray *audioArray = [userRecords objectForKey:AUDIO];
					AudioDataSource *table = (id)cell.wall.dataSource;
					[table setTableSet:audioArray];
					[cell.wall reloadData];
					result = cell;
					break;
				}
				
				default:
					break;
			}
			break;
		}
		default:
			break;
	}
	
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
		
		// create the new NSTextField with a frame of the {0,0} with the width of the table
		// note that the height of the frame is not really relevant, the row-height will modify the height
		// the new text field is then returned as an autoreleased object
		//result = [[[NSTableCellView alloc] initWithFrame:...] autorelease];
		
		// the identifier of the NSTextField instance is set to MyView. This
		// allows it to be re-used
		//result.identifier = @"MyView";
	}
	
	// result is now guaranteed to be valid, either as a re-used cell
	// or as a new cell, so set the stringValue of the cell to the
	// nameArray value at row
	
	//result.stringValue = [self.nameArray objectAtIndex:row];
	
	return result;
	
    //return [[tableSet objectAtIndex:row] objectForKey:[tableColumn identifier]]; 
}

- (NSUInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [tableSet count];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
	NSDictionary *userRecords = [tableSet objectAtIndex:row];
	unsigned int i = [[userRecords objectForKey:@"newsType"] unsignedIntValue];
	
	CGFloat height;
	switch (choice) {
		case kAudio:
			height = 70.0f;
			break;
			
		case kFriends:
			height = 50.0f;
			break;
		
		case kMessages:
			height = 180.0f;
			break;
		
		case kNews:
			switch (i) {
				case kNewsType1:
					height = 215.0f;
					break;
				case kNewsType2:
					height = 512.0f;
					break;
				case kNewsType3:
					height = 418.0f;
					break;
				case kNewsType4:
					height = 512.0f;
					break;
				case kNewsType5:
					height = 418.0f;
					break;
				case kNewsType6:
					height = 274.0f;
					break;
				case kNewsType7:
					height = 182.0f;
					break;
				case kNewsType8:
					height = 573.0f;
					break;
				case kNewsType9:
					height = 474.0f;
					break;
				case kNewsType10:
					height = 573.0f;
					break;
				case kNewsType11:
					height = 474.0f;
					break;
					
				case kNewsTypeG1:
					height = 215.0f;
					break;
				case kNewsTypeG2:
					height = 512.0f;
					break;
				case kNewsTypeG3:
					height = 418.0f;
					break;
				case kNewsTypeG4:
					height = 512.0f;
					break;
				case kNewsTypeG5:
					height = 418.0f;
					break;
				case kNewsTypeG6:
					height = 274.0f;
					break;
				case kNewsTypeG7:
					height = 182.0f;
					break;
				case kNewsTypeG8:
					height = 573.0f;
					break;
				case kNewsTypeG9:
					height = 474.0f;
					break;
				case kNewsTypeG10:
					height = 573.0f;
					break;
				case kNewsTypeG11:
					height = 474.0f;
					break;
					
				default:
					break;
			}
			break;
			
		default:
			break;
	}

	return height;
	
	/*NSSize cellSize = [[tableView preparedCellAtColumn:0 row:row] cellSize];
	
	[tableView noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndex:row]];
	
	if (cellSize.height > 0)
	{
		return cellSize.height;
	} else 
	{
		return [tableView rowHeight];
	}*/
}

/*- (CGFloat)tableView:(NSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	//NSString *text = [items objectAtIndex:[indexPath row]];
	
	//CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	
	//CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	//CGFloat height = MAX(size.height, 44.0f);
	
	//return height + (CELL_CONTENT_MARGIN * 2);
	CGFloat height = 100.0f;
	return height;
}*/

- (void) dealloc {
	[tableSet release];
	[super dealloc];
}

@end
