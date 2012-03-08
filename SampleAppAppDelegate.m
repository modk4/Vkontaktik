//
//  SampleAppAppDelegate.m
//  SampleApp
//
//  Created by Indragie Karunaratne on 11-02-23.
//  Copyright 2011 PCWiz Computer. All rights reserved.
//

#import "SampleAppAppDelegate.h"
#import "SampleWindowController.h"
#import "TableDataSource.h"

static NSImage *icon1, *icon2, *icon3, *icon4, *icon5, *icon11, *icon21, *icon31, *icon41, *icon51;

@implementation SampleAppAppDelegate

@synthesize window = _window;
@synthesize spinPanel = _spinPanel;
@synthesize delayVk = _delayVk;
@synthesize button1, button2, button3, button4, button5;
@synthesize wall = _wall;
@synthesize token = _token;
@synthesize friendsCount, audioCount, messageCount, newsCount, wallCount;
@synthesize userPic;
@synthesize friendsArray, newsArray, messageArray, wallArray, audioArray;
@synthesize updateTimer;

- (void)initApp
{
	// TO DO Возможно кэшировать все записи в массиве, перед очисткой
	
	// Получим записи со стены // [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"extended"]
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"wall.get" 
                                                              parameters: [NSDictionary dictionaryWithObject:@"1" forKey:@"extended"]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];

    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
				//NSLog(@"[SECOND] response: %@ (User News)\n", [response.response objectForKey:@"response"]);
				
				// Заполняем массив для таблицы
				NSDictionary *responseArray = [response.response objectForKey:@"response"];
				//NSArray *groups = [responseArray objectForKey:@"groups"];
				NSArray *items = [responseArray objectForKey:@"wall"];
				//NSArray *profiles = [responseArray objectForKey:@"profiles"];
				
				// Тупо берем количество записей в постах, потом их все-равно надо всех обрабатывать
				[wallCount setStringValue:[NSString stringWithFormat:@"%d", [items count]]];
				
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				//return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			//return;
        }
    } else {
		NSLog(@"Unable to get news.");
		//return;
		// Предупредить пользователя TO DO
	}
	
	[request setMethodName: @"friends.get"];
	[request setParameters: nil];
	
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				// Заполняем массив для таблицы
				NSArray *responseArray = [response.response objectForKey:@"response"];
				[friendsCount setStringValue:[NSString stringWithFormat:@"%d", [responseArray count]]];
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get friends.");
		//[NSApp terminate:nil];
	}
	
	[NSThread sleepForTimeInterval:1.0f];
	
	// Получим свое фото
	[request setMethodName: @"getUserInfoEx"];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (UserPic)\n", [[response.response objectForKey:@"response"] objectForKey: @"user_photo"]);
				//
				NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[[response.response objectForKey:@"response"] objectForKey: @"user_photo"]]];
				[userPic setImage:user];
				[user release];
            } else {
				// Предупредить, что нет разрешения для приложения
				// TODO
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get user photo.");
		//[NSApp terminate:nil];
	}
	
	[request setMethodName: @"audio.get"];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				NSArray *responseArray = [response.response objectForKey:@"response"];
				[audioCount setStringValue:[NSString stringWithFormat:@"%d", [responseArray count]]];
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get audio.");
		// Предупредить пользователя TO DO
	}
	
	[request setMethodName: @"messages.get"];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				NSArray *responseArray = [response.response objectForKey:@"response"];
				[messageCount setStringValue:[NSString stringWithFormat:@"%d", [responseArray count] - 1]];
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get message.");
		// Предупредить пользователя TO DO
	}
	
	[NSThread sleepForTimeInterval:1.0f];
	
	// Получим новости
	[request setMethodName: @"newsfeed.get"];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
				//NSLog(@"[SECOND] response: %@ (User News)\n", [response.response objectForKey:@"response"]);
				
				// Заполняем массив для таблицы
				NSDictionary *responseArray = [response.response objectForKey:@"response"];
				//NSArray *groups = [responseArray objectForKey:@"groups"];
				NSArray *items = [responseArray objectForKey:@"items"];
				//NSArray *profiles = [responseArray objectForKey:@"profiles"];
				
				// Тупо берем количество записей в постах, потом их все-равно надо всех обрабатывать
				[newsCount setStringValue:[NSString stringWithFormat:@"%d", [items count]]];

            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				//return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			//return;
        }
    } else {
		NSLog(@"Unable to get news.");
		//return;
		// Предупредить пользователя TO DO
	}
	
	[self performClick4:self];
	
	[_delayVk stopAnimation:self];
	[_spinPanel orderOut:nil];
	[_window center];
	[_window orderFront:nil];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int row = [[_wall selectedCellRowIndex] intValue];
    int col = [[_wall selectedCellColumnIndex] intValue];
    //NSLog(@"Selected Row: %d Selected Column: %d", row, col);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{	
    // Icon in StatusBar
	NSBundle *mainBundle;
    NSString *path;
    
    mainBundle = [NSBundle mainBundle];
	path = [mainBundle pathForResource:@"button-1" ofType:@"png"];
    icon1 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-2" ofType:@"png"];
    icon2 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-3" ofType:@"png"];
    icon3 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-4" ofType:@"png"];
    icon4 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-5" ofType:@"png"];
    icon5 = [[NSImage alloc] initByReferencingFile:path];
	
	path = [mainBundle pathForResource:@"button-1-1" ofType:@"png"];
    icon11 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-2-1" ofType:@"png"];
    icon21 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-3-1" ofType:@"png"];
    icon31 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-4-1" ofType:@"png"];
    icon41 = [[NSImage alloc] initByReferencingFile:path];
	path = [mainBundle pathForResource:@"button-5-1" ofType:@"png"];
    icon51 = [[NSImage alloc] initByReferencingFile:path];
	
	sound = nil;
	currentSoundRow = -1;
	
	friendsArray = newsArray = messageArray = wallArray = audioArray = nil;
	
	// Переделать на асинхронные запросы TODO
	// Поставить таймаут, если запросы к вконтакте слишком долгие
	NSError *error = nil;
    
    int settings = EBSettingsStatusAccess | EBSettingsAllowNotifications | EBSettingsWallAccess | EBSettingsMessagesAccess;
    token = [[EBVKAPIToken alloc] initWithEmail: USER_EMAIL 
                                                     password: USER_PASSWORD 
                                                applicationID: APP_ID 
													 settings: settings
                                                        error: &error];
    if (!token) {
        NSLog(@"Unable to log on. Reason:");
        NSLog(@"%@", [error localizedDescription]);
		[NSApp terminate:nil];
    }
	
	[_wall addObserver:self forKeyPath:@"selectedCellRowIndex" options:NSKeyValueObservingOptionNew context:nil];
    [_wall addObserver:self forKeyPath:@"selectedCellColumnIndex" options:NSKeyValueObservingOptionNew context:nil];
	
	[self performSelectorInBackground:@selector(initApp) withObject:nil];
	//[self initApp];
	
	//[progressBar setUsesThreadedAnimation:YES];
	
	[[NSApplication sharedApplication] activateIgnoringOtherApps:TRUE];
	
	[_spinPanel orderFront:nil];
	[_delayVk startAnimation:nil];
	
	NSInteger interval = 300;
	self.updateTimer = [[NSTimer scheduledTimerWithTimeInterval:interval
														 target:self selector:@selector(updateVk:)
													   userInfo:nil repeats:YES] retain];
}

- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
	
}

- (void)checkVk
{
	[self openFriends];
	[self openAudio];
	[self openMessage];
	[self openNews];
	[self openWall];
}

- (void)updateVk:(NSTimer *)aTimer
{
	NSLog(@"Start update for timer");
	[self performSelectorInBackground:@selector(checkVk) withObject:nil];
}

- (void)openFriends
{
	NSMutableArray *friendsArrayTemp = [[NSMutableArray alloc] init];
	/*
	 uid, first_name, last_name, nickname, sex, bdate (birthdate), city, country, timezone, photo, photo_medium, photo_big, domain, has_mobile, rate, contacts, education
	 */
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"friends.get" 
                                                              parameters: [NSDictionary dictionaryWithObject:@"first_name, last_name, nickname, photo" forKey:@"fields"]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				/*
				 {
				 "first_name" = Marina;
				 "last_name" = Shubina;
				 lists =         (
				 27
				 );
				 online = 0;
				 photo = "http://cs11072.vk.com/u52758/e_ad948ece.jpg";
				 uid = 52758;
				 },
				 */
				// Заполняем массив для таблицы
				NSArray *responseArray = [response.response objectForKey:@"response"];
				for (int i = 0; i < [responseArray count]; i++) {
					NSDictionary *userDic = [responseArray objectAtIndex:i];
					NSMutableDictionary *newUserRecord = [NSMutableDictionary dictionaryWithCapacity:3];
					NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [userDic objectForKey:@"first_name"], [userDic objectForKey:@"last_name"], [[userDic objectForKey:@"online"] boolValue]?@" ☻":@""];
					[newUserRecord setObject:userName forKey:USERNAME];
					NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[userDic objectForKey:@"photo"]]];
					[newUserRecord setObject:[userDic objectForKey:@"online"] forKey:ONLINE];
					[newUserRecord setObject:user forKey:USERPIC];
					[friendsArrayTemp addObject:newUserRecord];
					[user release];
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			return;
        }
    } else {
		NSLog(@"Unable to get friends.");
		return;
		//[NSApp terminate:nil];
	}
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ONLINE ascending:FALSE];
	[friendsArrayTemp sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	if (friendsArray) {
		[friendsArray release];
	}
	friendsArray = [friendsArrayTemp retain];
	[friendsCount setStringValue:[NSString stringWithFormat:@"%d", [friendsArray count]]];
	[friendsArrayTemp release];
	//NSLog(@"Our Dictionary: %@ (User Friends)\n", tableArray);
}

- (NSMutableDictionary *)getUsers:(NSMutableDictionary *)uids
{
	NSMutableDictionary *users = nil;
	if (![uids count]) {
		return users;
	}
	
	NSString *parametrsUid = nil;
	NSArray *keys = [uids allKeys];
	for (int i = 0; i < [keys count]; i++) {
		if (parametrsUid) {
			parametrsUid = [NSString stringWithFormat:@"%@,%@", parametrsUid, [keys objectAtIndex:i]];
		} else {
			parametrsUid = [NSString stringWithFormat:@"%@", [keys objectAtIndex:i]];
		}
	}
	//NSLog(@"Parametrs: %@", parametrsUid);
	
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"getProfiles" 
                                                              parameters: [NSDictionary dictionaryWithObjectsAndKeys:parametrsUid, @"uids", @"first_name, last_name, photo, online", @"fields", nil]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				/*
				 {
				 "first_name" = Marina;
				 "last_name" = Shubina;
				 lists =         (
				 27
				 );
				 online = 0;
				 photo = "http://cs11072.vk.com/u52758/e_ad948ece.jpg";
				 uid = 52758;
				 },
				 */
				// Заполняем массив для таблицы
				NSArray *responseArray = [response.response objectForKey:@"response"];
				if ([responseArray count]) {
					users = [[NSMutableDictionary alloc] init];
				}
				for (int i = 0; i < [responseArray count]; i++) {
					NSDictionary *userDic = [responseArray objectAtIndex:i];
					NSMutableDictionary *newUserRecord = [NSMutableDictionary dictionaryWithCapacity:3];
					NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [userDic objectForKey:@"first_name"], [userDic objectForKey:@"last_name"], [[userDic objectForKey:@"online"] boolValue]?@" ☻":@""];
					[newUserRecord setObject:userName forKey:USERNAME];
					NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[userDic objectForKey:@"photo"]]];
					//[newUserRecord setObject:[userDic objectForKey:@"online"] forKey:ONLINE];
					[newUserRecord setObject:user forKey:USERPIC];
					[users setObject:newUserRecord forKey:[[userDic objectForKey:@"uid"] stringValue]];
					[user release];
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get users.");
		//[NSApp terminate:nil];
	}
	
	if (users) {
		[users retain];
		[users release];
	}
	return users;
}

- (void)openMessage
{
	NSMutableArray *messageArrayTemp = [[NSMutableArray alloc] init];
	
	NSMutableDictionary *uids = [NSMutableDictionary dictionary];
	
	/*
	 uid, first_name, last_name, nickname, sex, bdate (birthdate), city, country, timezone, photo, photo_medium, photo_big, domain, has_mobile, rate, contacts, education
	 */
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"messages.get" 
                                                              parameters: [NSDictionary dictionaryWithObject:@"0" forKey:@"preview_length"]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Message)\n", [response.response objectForKey:@"response"]);
				/*
				 {
				 body = "\U043a\U043e\U043d\U0435\U0447\U043d\U043e \U0440\U0430\U0441\U0441\U043a\U0430\U0436\U0435\U043c";
				 date = 1328252237;
				 mid = 750;
				 out = 0;
				 "read_state" = 1;
				 title = " ... ";
				 uid = 20527862;
				 },
				 */
				// Заполняем массив для таблицы
				// TO DO Сделать показ онлайн для пользователя
				NSArray *responseArray = [response.response objectForKey:@"response"];
				for (int i = 0; i < [responseArray count]; i++) {
					if (i == 0) {
						continue;
					}
					NSDictionary *userDic = [responseArray objectAtIndex:i];
					NSMutableDictionary *newUserRecord = [NSMutableDictionary dictionaryWithCapacity:7];
					
					NSString *message = [userDic objectForKey:@"body"];
					NSString *title = [userDic objectForKey:@"title"];
					NSNumber *uid = [userDic objectForKey:@"uid"];
					
					[uids setObject:uid forKey:[uid stringValue]];
					
					NSNumber *read_state = [userDic objectForKey:@"read_state"];
					NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[userDic objectForKey:@"date"] longLongValue]];
					
					NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
					[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
					
					NSString *stringDate = [dateFormatter stringFromDate:date];
					[dateFormatter release];
					
					[newUserRecord setObject:message forKey:MESSAGE];
					[newUserRecord setObject:title forKey:TITLE];
					[newUserRecord setObject:uid forKey:UID];
					[newUserRecord setObject:read_state forKey:READSTATE];
					[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
					
					[messageArrayTemp addObject:newUserRecord];
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			return;
        }
    } else {
		// TO DO Сообщение пользователю
		NSLog(@"Unable to get message.");
		return;
		//[NSApp terminate:nil];
	}
	
	// Собрать информацию о пользователях, приславших сообщения
	// TO DO Хранить массив пользователей
	NSMutableDictionary *users = [self getUsers:uids];
	if (users) {
		for (int i = 0; i < [messageArrayTemp count]; i++) {
			NSMutableDictionary *rec = [messageArrayTemp objectAtIndex:i];
			NSString *key = [[rec objectForKey:UID] stringValue];
			NSDictionary *user = [users objectForKey:key];
			if (user) {
				[rec setObject:[user objectForKey:USERNAME] forKey:USERNAME];
				[rec setObject:[user objectForKey:USERPIC] forKey:USERPIC];
			}
		}
		[users release];
	}
	/*
	 NSString *userName = [NSString stringWithFormat:@"%@ %@", [userDic objectForKey:@"first_name"], [userDic objectForKey:@"last_name"], [[userDic objectForKey:@"online"] boolValue]?@" ☻":@""];
	 [newUserRecord setObject:userName forKey:USERNAME];
	 NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[userDic objectForKey:@"photo"]]];
	 [newUserRecord setObject:[userDic objectForKey:@"online"] forKey:ONLINE];
	 [newUserRecord setObject:user forKey:USERPIC];
	 [user release];
	*/
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:READSTATE ascending:FALSE];
	[messageArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	if (messageArray) {
		[messageArray release];
	}
	messageArray = [messageArrayTemp retain];
	[messageCount setStringValue:[NSString stringWithFormat:@"%d", [messageArray count]]];
	[messageArrayTemp release];
	//NSLog(@"Our Dictionary: %@ (User Friends)\n", tableArray);
}

- (void) openAudio
{
	NSMutableArray *audioArrayTemp = [[NSMutableArray alloc] init];
	
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"audio.get" 
                                                              parameters: nil	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
                //NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				/*
				 <audio>
				 <aid>60830458</aid>
				 <owner_id>1234</owner_id>
				 <artist>Unknown</artist>
				 <title>Bosco</title>
				 <duration>195</duration>
				 <url>httр://cs40.vkоntakte.ru/u06492/audio/2ce49d2b88.mp3</url>
				 </audio>
				 <audio>
				 <aid>59317035</aid>
				 <owner_id>1234</owner_id>
				 <artist>Mestre Barrao</artist>
				 <title>Sinhazinha</title>
				 <duration>234</duration>
				 <url>httр://cs510.vkоntakte.ru/u2082836/audio/d100f76cb84e.mp3</url>
				 </audio>
				 */
				// Заполняем массив для таблицы
				NSArray *responseArray = [response.response objectForKey:@"response"];
				for (int i = 0; i < [responseArray count]; i++) {
					NSDictionary *userDic = [responseArray objectAtIndex:i];
					NSMutableDictionary *newUserRecord = [NSMutableDictionary dictionaryWithCapacity:4];
					NSString *artist = [userDic objectForKey:ARTIST];
					NSString *title = [[userDic objectForKey:TITLE] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
					NSString *url = [userDic objectForKey:URL];
					//NSLog(@"%@", [[userDic objectForKey:@"duration"] class]);
					double progress = [[userDic objectForKey:@"duration"] doubleValue];
					int minutes = floor(progress/60);
					int seconds = trunc(progress - minutes * 60);
					NSString *duration;
					if (seconds < 10) {
						duration = [NSString stringWithFormat:@"Duration: %d:0%d", minutes, seconds];
					} else duration = [NSString stringWithFormat:@"Duration: %d:%d", minutes, seconds];
					//NSLog(@"Duration: %dmin %dsec", minutes, seconds);
					[newUserRecord setObject:duration forKey:DURATION];
					[newUserRecord setObject:artist forKey:ARTIST];
					[newUserRecord setObject:title forKey:TITLE];
					[newUserRecord setObject:url forKey:URL];
					[audioArrayTemp addObject:newUserRecord];
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			return;
        }
    } else {
		NSLog(@"Unable to get audio.");
		return;
		// Предупредить пользователя TO DO
	}
	if (audioArray) {
		[audioArray release];
	}
	audioArray = [audioArrayTemp retain];
	[audioCount setStringValue:[NSString stringWithFormat:@"%d", [audioArray count]]];
	[audioArrayTemp release];
	//NSLog(@"Our Dictionary: %@ (User Audio)\n", tableArray);
}

- (NSString *)flattenHTML:(NSString *)decodeStr
{
	NSString *result = @"";
	
	if (![decodeStr isEqualToString:@""])	// if empty string, don't do this!  You get junk.
	{
		// HACK -- IF SHORT LENGTH, USE MACROMAN -- FOR SOME REASON UNICODE FAILS FOR "" AND "-" AND "CNN" ...
		
		int encoding = ([decodeStr length] > 3) ? NSUnicodeStringEncoding : NSMacOSRomanStringEncoding;
		NSAttributedString *attrString;
		NSData *theData = [decodeStr dataUsingEncoding:encoding];
		if (nil != theData)	// this returned nil once; not sure why; so handle this case.
		{
			NSDictionary *encodingDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:encoding] forKey:@"CharacterEncoding"];
			attrString
			= [[NSAttributedString alloc]
			   initWithHTML:theData documentAttributes:&encodingDict];
			result = [[[attrString string] retain] autorelease];	// keep only this
			[attrString release];	// don't do autorelease since this is so deep down.
		}
	}
	return result;
}

- (NSMutableArray *)getAudio:(NSArray *)aid
{
	NSMutableArray *audio = nil;
	if (![aid count]) {
		return audio;
	}
	
	NSString *parametrsUid = nil;
	for (int i = 0; i < [aid count]; i++) {
		NSDictionary *item = [aid objectAtIndex:i];
		if (parametrsUid) {
			parametrsUid = [NSString stringWithFormat:@"%@,%@_%@", parametrsUid, [[item objectForKey:@"id"] stringValue], [[item objectForKey:@"aid"] stringValue]];
		} else {
			parametrsUid = [NSString stringWithFormat:@"%@_%@", [[item objectForKey:@"id"] stringValue], [[item objectForKey:@"aid"] stringValue]];
		}
	}
	//NSLog(@"Parametrs: %@", parametrsUid);
	
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"audio.getById" //parametrsUid forKey:@"aids"
                                                              parameters: [NSDictionary dictionaryWithObject:parametrsUid forKey:@"audios"]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
				//NSLog(@"[SECOND] response: %@ (User Friends)\n", [response.response objectForKey:@"response"]);
				// Заполняем массив для таблицы
				NSArray *responseArray = [response.response objectForKey:@"response"];
				if ([responseArray count]) {
					audio = [[NSMutableArray alloc] init];
				}
				for (int i = 0; i < [responseArray count]; i++) {
					NSDictionary *userDic = [responseArray objectAtIndex:i];
					NSMutableDictionary *newUserRecord = [NSMutableDictionary dictionaryWithCapacity:4];
					NSString *artist = [userDic objectForKey:ARTIST];
					NSString *title = [[userDic objectForKey:TITLE] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
					NSString *url = [userDic objectForKey:URL];
					double progress = [[userDic objectForKey:@"duration"] doubleValue];
					int minutes = floor(progress/60);
					int seconds = trunc(progress - minutes * 60);
					NSString *duration;
					if (seconds < 10) {
						duration = [NSString stringWithFormat:@"Duration: %d:0%d", minutes, seconds];
					} else duration = [NSString stringWithFormat:@"Duration: %d:%d", minutes, seconds];
					[newUserRecord setObject:duration forKey:DURATION];
					[newUserRecord setObject:artist forKey:ARTIST];
					[newUserRecord setObject:title forKey:TITLE];
					[newUserRecord setObject:url forKey:URL];
					[audio addObject:newUserRecord];
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
        }
    } else {
		NSLog(@"Unable to get audio.");
		//[NSApp terminate:nil];
	}
	
	if (audio) {
		[audio retain];
		[audio release];
	}
	return audio;
}

- (void) openNews
{
	NSMutableArray *newsArrayTemp = [[NSMutableArray alloc] init];
	
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"newsfeed.get" 
                                                              parameters: nil	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
				//NSLog(@"[SECOND] response: %@ (User News)\n", [response.response objectForKey:@"response"]);
				
				// Заполняем массив для таблицы
				NSDictionary *responseArray = [response.response objectForKey:@"response"];
				NSArray *groups = [responseArray objectForKey:@"groups"];
				NSArray *items = [responseArray objectForKey:@"items"];
				NSArray *profiles = [responseArray objectForKey:@"profiles"];
				//unsigned int flag;
				
				for (int i = 0; i < [items count]; i++) {
					NSDictionary *post = [items objectAtIndex:i];
					if (![[post objectForKey:@"type"] isEqual:@"post"]) { // Пока не понятно, от чего защищаемся
						// Может быть еще type = photo, где просто фотографии
						// Состоит из даты, source_id, и массива фотографий
						continue;
					}
					// Ищем автора
					NSNumber *authorId = [post objectForKey:@"source_id"];
					if (!authorId || [authorId longLongValue] < 0) {
						continue;
					}
					
					NSNumber *groipId = [post objectForKey:@"copy_owner_id"];
					BOOL isGroup = FALSE;
					BOOL isFriend = FALSE;
					if (groipId && [groipId longLongValue] < 0) {
						// Пост взят из группы
						isGroup = TRUE;
						// Небходимо инвертировать в положителльное
						groipId = [NSNumber numberWithLongLong:[groipId longLongValue] * -1];
					} else if (groipId) {
						// Перепост от друга, можем использовать шаблон группы
						isFriend = TRUE;
						groipId = [NSNumber numberWithLongLong:[groipId longLongValue]];
					}
					
					NSMutableDictionary *newUserRecord;
					
					// Ищем в массиве пользователей, он то точно должен быть
					int i = 0;
					NSDictionary *profile = nil;
					for (; i < [profiles count]; i++) {
						profile = [profiles objectAtIndex:i];
						NSNumber *uid = [profile objectForKey:@"uid"];
						if (uid && [uid longLongValue] == [authorId longLongValue]) {
							break; // Нашли профиль пользователя
						}
					}
					if (!profile || i == [profiles count]) {
						continue;
					}
					
					BOOL isText = FALSE;
					NSString *message = [post objectForKey:@"text"];
					if (message && [message length]) isText = TRUE;
					
					BOOL isAttachments = FALSE;
					NSDictionary *attachment = [post objectForKey:@"attachment"];
					if (attachment && ([attachment objectForKey:@"photo"] || [attachment objectForKey:@"video"] || [attachment objectForKey:@"audio"])) isAttachments = TRUE;
					// Надо проверить есть ли в массиве аудио
					BOOL isAudio = FALSE;
					NSArray *attachments = [post objectForKey:@"attachments"];
					NSMutableArray *audioDic = [NSMutableArray array];
					if (attachments) {
						for (int i = 0; i < [attachments count]; i++) {
							NSDictionary *audio = [attachments objectAtIndex:i];
							if ([[audio objectForKey:@"type"] isEqual:@"audio"]) {
								isAudio = TRUE;
								NSDictionary *audioRec = [audio objectForKey:@"audio"];
								//NSLog(@"Audio Rec: %@", audioRec);
								//NSLog(@"Audio AID class: %@", [[audioRec objectForKey:@"aid"] class]);
								NSNumber *aid = [audioRec objectForKey:@"aid"];
								NSNumber *uid = [audioRec objectForKey:@"owner_id"];
								NSDictionary *newRec = [NSDictionary dictionaryWithObjectsAndKeys:aid, @"aid", uid, @"id", nil];
								[audioDic addObject:newRec];
							}
						}
					}
					
					//NSLog(@"Attach: %@", attachment);
					
					/******************/
					if (isGroup || isFriend) { // Пошли по группе
						NSDictionary *groupProfile = nil;
						// Найдем группу
						int i = 0;
						if (isGroup) {
							for (; i < [groups count]; i++) {
								groupProfile = [groups objectAtIndex:i];
								NSNumber *uid = [groupProfile objectForKey:@"gid"];
								if (uid && [groipId longLongValue] == [uid longLongValue]) {
									break;
								}
							}
						} else {
							for (; i < [profiles count]; i++) {
								groupProfile = [profiles objectAtIndex:i];
								NSNumber *uid = [groupProfile objectForKey:@"uid"];
								if (uid && [groipId longLongValue] == [uid longLongValue]) {
									break;
								}
							}
						}
						
						
						/******************/
						if (isText) {
							// Есть текст
							
							/******************/
							if (isAttachments) {
								// Есть вложение
								newUserRecord = [NSMutableDictionary dictionary];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG2] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG8] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG4] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, видео и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG10] forKey:@"newsType"];
											}
										}
									} else {
										// Audio
										// Чистое аудио
										if (isAudio) {
											// Другой тип, аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG6] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							} else {
								// Нет вложения
								
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG1] forKey:@"newsType"];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							}
							
						} else {
							// Без текста
							
							if (isAttachments) {
								// С вложением
								newUserRecord = [NSMutableDictionary dictionary];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG3] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG9] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG5] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, видео и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG11] forKey:@"newsType"];
											}
										}
									} else {
										// Другое вложение
										if (isAudio) {
											// Другой тип, аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG7] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
								
							} else {
								// Без вложения
								// Значит этого не может быть!!! TO DO

								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG5] forKey:@"newsType"];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							}
						}
					} else {
						// Без группы
						/******************/
						if (isText) {
							// Есть текст
							
							/******************/
							if (isAttachments) {
								// Есть вложение
								newUserRecord = [NSMutableDictionary dictionary];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType2] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType8] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType4] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType10] forKey:@"newsType"];
											}
										}
									} else {
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType6] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							} else {
								// Нет вложения
								
								// Имя и картинка группы
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType1] forKey:@"newsType"];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							}
							
						} else {
							// Без текста
							
							if (isAttachments) {
								// С вложением
								newUserRecord = [NSMutableDictionary dictionary];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType3] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType9] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType5] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType11] forKey:@"newsType"];
											}
										}
									} else {
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType7] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
								
							} else {
								// Без вложения
								// Значит этого не может быть!!! TO DO
								
								// Имя и картинка группы
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType5] forKey:@"newsType"];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[newsArrayTemp addObject:newUserRecord];
							}
						}
					}
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			return;
        }
    } else {
		NSLog(@"Unable to get news.");
		return;
		// Предупредить пользователя TO DO
	}
	if (newsArray) {
		[newsArray release];
	}
	newsArray = [newsArrayTemp retain];
	[newsCount setStringValue:[NSString stringWithFormat:@"%d", [newsArray count]]];
	[newsArrayTemp release];
	//NSLog(@"Our Dictionary: %@ (User Audio)\n", tableArray);
}

- (void) openWall
{
	NSMutableArray *wallArrayTemp = [[NSMutableArray alloc] init];
	
	
	EBVKAPIRequest *request = [[EBVKAPIRequest alloc] initWithMethodName: @"wall.get" 
                                                              parameters: [NSDictionary dictionaryWithObject:@"1" forKey:@"extended"]	 
                                                          responseFormat: EBJSONFormat];
	EBVKAPIResponse *response = [[EBVKAPIResponse alloc] init];
    response = [request sendRequestWithToken: token];
    if (response) {
        if (response.response) {
            if ([response.response objectForKey:@"response"]) {
				//NSLog(@"[SECOND] response: %@ (User News)\n", [response.response objectForKey:@"response"]);
				
				// Заполняем массив для таблицы
				NSDictionary *responseArray = [response.response objectForKey:@"response"];
				NSArray *groups = [responseArray objectForKey:@"groups"];
				NSArray *items = [responseArray objectForKey:@"wall"];
				NSArray *profiles = [responseArray objectForKey:@"profiles"];
				//unsigned int flag;
				for (int i = 1; i < [items count]; i++) {
					NSDictionary *post = [items objectAtIndex:i];
					NSLog(@"Post: %@", post);
					// Ищем автора
					NSNumber *authorId = [post objectForKey:@"from_id"];
					if (!authorId || [authorId longLongValue] < 0) {
						continue;
					}
					
					NSNumber *groipId = [post objectForKey:@"from_id"];
					BOOL isGroup = FALSE;
					BOOL isFriend = FALSE;
					if (groipId && [groipId longLongValue] < 0) {
						// Пост взят из группы
						isGroup = TRUE;
						// Небходимо инвертировать в положителльное
						groipId = [NSNumber numberWithLongLong:[groipId longLongValue] * -1];
					} else if (groipId) {
						// Перепост от друга, можем использовать шаблон группы
						isFriend = TRUE;
						groipId = [NSNumber numberWithLongLong:[groipId longLongValue]];
					}
					
					NSMutableDictionary *newUserRecord;
					
					// Ищем в массиве пользователей, он то точно должен быть
					int i = 0;
					NSDictionary *profile = nil;
					for (; i < [profiles count]; i++) {
						profile = [profiles objectAtIndex:i];
						NSNumber *uid = [profile objectForKey:@"uid"];
						if (uid && [uid longLongValue] == [authorId longLongValue]) {
							break; // Нашли профиль пользователя
						}
					}
					if (!profile || i == [profiles count]) {
						continue;
					}
					
					BOOL isText = FALSE;
					NSString *message = [post objectForKey:@"text"];
					if (message && [message length]) isText = TRUE;
					
					BOOL isAttachments = FALSE;
					NSDictionary *attachment = [post objectForKey:@"attachment"];
					if (attachment && ([attachment objectForKey:@"photo"] || [attachment objectForKey:@"video"] || [attachment objectForKey:@"audio"])) isAttachments = TRUE;
					// Надо проверить есть ли в массиве аудио
					BOOL isAudio = FALSE;
					NSArray *attachments = [post objectForKey:@"attachments"];
					NSMutableArray *audioDic = [NSMutableArray array];
					if (attachments) {
						for (int i = 0; i < [attachments count]; i++) {
							NSDictionary *audio = [attachments objectAtIndex:i];
							if ([[audio objectForKey:@"type"] isEqual:@"audio"]) {
								isAudio = TRUE;
								NSDictionary *audioRec = [audio objectForKey:@"audio"];
								//NSLog(@"Audio Rec: %@", audioRec);
								//NSLog(@"Audio AID class: %@", [[audioRec objectForKey:@"aid"] class]);
								NSNumber *aid = [audioRec objectForKey:@"aid"];
								NSNumber *uid = [audioRec objectForKey:@"owner_id"];
								NSDictionary *newRec = [NSDictionary dictionaryWithObjectsAndKeys:aid, @"aid", uid, @"id", nil];
								[audioDic addObject:newRec];
							}
						}
					}
					
					//NSLog(@"Attach: %@", attachment);
					
					/******************/
					if (isGroup || isFriend) { // Пошли по группе
						NSDictionary *groupProfile = nil;
						// Найдем группу
						int i = 0;
						if (isGroup) {
							for (; i < [groups count]; i++) {
								groupProfile = [groups objectAtIndex:i];
								NSNumber *uid = [groupProfile objectForKey:@"gid"];
								if (uid && [groipId longLongValue] == [uid longLongValue]) {
									break;
								}
							}
						} else {
							for (; i < [profiles count]; i++) {
								groupProfile = [profiles objectAtIndex:i];
								NSNumber *uid = [groupProfile objectForKey:@"uid"];
								if (uid && [groipId longLongValue] == [uid longLongValue]) {
									break;
								}
							}
						}
						
						
						/******************/
						if (isText) {
							// Есть текст
							
							/******************/
							if (isAttachments) {
								// Есть вложение
								newUserRecord = [NSMutableDictionary dictionary];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG2] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG8] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG4] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, видео и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG10] forKey:@"newsType"];
											}
										}
									} else {
										// Audio
										// Чистое аудио
										if (isAudio) {
											// Другой тип, аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG6] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							} else {
								// Нет вложения
								
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG1] forKey:@"newsType"];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							}
							
						} else {
							// Без текста
							
							if (isAttachments) {
								// С вложением
								newUserRecord = [NSMutableDictionary dictionary];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG3] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG9] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG5] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, видео и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG11] forKey:@"newsType"];
											}
										}
									} else {
										// Другое вложение
										if (isAudio) {
											// Другой тип, аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG7] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
								
							} else {
								// Без вложения
								// Значит этого не может быть!!! TO DO
								
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsTypeG5] forKey:@"newsType"];
								
								// Имя и картинка группы
								NSString *groupName;
								if (isFriend) {
									groupName = [NSString stringWithFormat:@"%@ %@%@", [groupProfile objectForKey:@"first_name"], [groupProfile objectForKey:@"last_name"], [[groupProfile objectForKey:@"online"] boolValue]?@" ☻":@""];
								} else {
									groupName = [groupProfile objectForKey:@"name"];
								}
								if (groupName) {
									[newUserRecord setObject:groupName forKey:GROUPNAME];
								}
								NSImage *groupPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[groupProfile objectForKey:@"photo"]]];
								[newUserRecord setObject:groupPic forKey:GROUPPIC];
								[groupPic release];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							}
						}
					} else {
						// Без группы
						/******************/
						if (isText) {
							// Есть текст
							
							/******************/
							if (isAttachments) {
								// Есть вложение
								newUserRecord = [NSMutableDictionary dictionary];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType2] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType8] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType4] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType10] forKey:@"newsType"];
											}
										}
									} else {
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType6] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							} else {
								// Нет вложения
								
								// Имя и картинка группы
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType1] forKey:@"newsType"];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								// Почему то иногда остается <br>
								NSString *message = [[self flattenHTML:[post objectForKey:@"text"]] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
								[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							}
							
						} else {
							// Без текста
							
							if (isAttachments) {
								// С вложением
								newUserRecord = [NSMutableDictionary dictionary];
								
								NSDictionary *photoLink = [attachment objectForKey:@"photo"];
								if (photoLink) {
									// Фотография
									NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"src_big"]]];
									[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
									[atPic release];
									
									// ************
									[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType3] forKey:@"newsType"];
									if (isAudio) {
										// Другой тип, фото и аудио
										NSArray *audioRecords = [self getAudio:audioDic];
										if (audioRecords) {
											[newUserRecord setObject:audioRecords forKey:AUDIO];
											[audioRecords release];
											[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType9] forKey:@"newsType"];
										}
									}
								} else {
									photoLink = [attachment objectForKey:@"video"];
									if (photoLink) {
										// Фотография
										NSImage *atPic = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[photoLink objectForKey:@"image_big"]]];
										[newUserRecord setObject:atPic forKey:ATTACHMENTSPHOTO];
										[atPic release];
										
										// ************
										[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType5] forKey:@"newsType"];
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType11] forKey:@"newsType"];
											}
										}
									} else {
										if (isAudio) {
											// Другой тип, фото и аудио
											NSArray *audioRecords = [self getAudio:audioDic];
											if (audioRecords) {
												[newUserRecord setObject:audioRecords forKey:AUDIO];
												[audioRecords release];
												[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType7] forKey:@"newsType"];
											}
										} else {
											continue;
										}
									}
								}
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
								
							} else {
								// Без вложения
								// Значит этого не может быть!!! TO DO
								
								// Имя и картинка группы
								newUserRecord = [NSMutableDictionary dictionary];
								
								// ************
								[newUserRecord setObject:[NSNumber numberWithUnsignedInt:kNewsType5] forKey:@"newsType"];
								
								NSString *userName = [NSString stringWithFormat:@"%@ %@%@", [profile objectForKey:@"first_name"], [profile objectForKey:@"last_name"], [[profile objectForKey:@"online"] boolValue]?@" ☻":@""];
								[newUserRecord setObject:userName forKey:USERNAME];
								NSImage *user = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[profile objectForKey:@"photo"]]];
								[newUserRecord setObject:user forKey:USERPIC];
								[user release];
								
								//NSString *message = [post objectForKey:@"text"];
								//[newUserRecord setObject:message forKey:MESSAGE];
								
								NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[post objectForKey:@"date"] longLongValue]];
								NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
								[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
								NSString *stringDate = [dateFormatter stringFromDate:date];
								[dateFormatter release];
								[newUserRecord setObject:stringDate forKey:DATEMESSAGE];
								
								[wallArrayTemp addObject:newUserRecord];
							}
						}
					}
				}
            } else {
                NSLog(@"[SECOND]: API server error : %@",
                      [response.response objectForKey: @"error"]);
				return;
            }
        } else {
            NSLog(@"[SECOND] internal EBVKAPI error :%@\n", [response.error localizedDescription]);
			return;
        }
    } else {
		NSLog(@"Unable to get news.");
		return;
		// Предупредить пользователя TO DO
	}
	
	if (wallArray) {
		[wallArray release];
	}
	wallArray = [wallArrayTemp retain];
	[wallArrayTemp release];
	
	[wallCount setStringValue:[NSString stringWithFormat:@"%d", [wallArray count]]];
	//NSLog(@"Our Dictionary: %@ (User Audio)\n", tableArray);
}

- (IBAction) btnInCellClicked:(id)sender {
    NSInteger row = [_wall rowForView:sender];
	if (row == -1) {
		// Проверим, если мы в новосят или на стене
		row = [[_wall selectedCellRowIndex] integerValue];
		if (row == -1) {
			return;
		}
	}

	TableDataSource *table = (id)_wall.dataSource;
	NSArray *tableArray = table.tableSet;
    NSDictionary *entity = [tableArray objectAtIndex:row];
	NSString *url = nil;
	
	NSInteger rowAudio = -1;
	if (table.choice == kNews) {
		// Ищем массив аудио в записях новостей или на стене
		NSArray *audio = [entity objectForKey:AUDIO];
		if (audio) {
			// Ищем индекс в таблице аудио
			ATNewsCellOne6 *cell = [_wall selectedCell];
			rowAudio = [cell.wall rowForView:sender];
			NSDictionary *audioRec = [audio objectAtIndex:rowAudio];
			url = [audioRec objectForKey:URL];
		}
	} else {
		url = [entity objectForKey:URL];
	}
	
	if (!url) {
		return;
	}
	
	// NSGoRightTemplate
	// NSStopProgressTemplate
	if (currentSoundRow != -1) {
		// Значит что-то играет
		if (currentSoundRow == row) {
			// Значит нажали на этой же и если играет, надо остановить
			if ([sound isPlaying]) {
				[sound stop];
				[sound release];
				sound = nil;
				[(NSButton *)sender setImage:[NSImage imageNamed:@"NSGoRightTemplate"]];
			} else {
				// Не играет
				sound = [[NSSound alloc] initWithContentsOfURL:[NSURL URLWithString:url] byReference:NO];
				[sound play];
				[(NSButton *)sender setImage:[NSImage imageNamed:@"NSStopProgressTemplate"]];
			}
		} else {
			// Остановить предыдущую и начать новую
			// Найти кнопку, которую надо остановить
			currentSoundRow = row;
			if ([sound isPlaying]) {
				[sound stop];
				[sound release];
				sound = nil;
				[(NSButton *)currentPlay setImage:[NSImage imageNamed:@"NSGoRightTemplate"]];
			}
			sound = [[NSSound alloc] initWithContentsOfURL:[NSURL URLWithString:url] byReference:NO];
			[sound play];
			[(NSButton *)sender setImage:[NSImage imageNamed:@"NSStopProgressTemplate"]];
			currentPlay = sender;
		}
	} else {
		// Только нажали
		currentSoundRow = row;
		sound = [[NSSound alloc] initWithContentsOfURL:[NSURL URLWithString:url] byReference:NO];
		[sound play];
		[(NSButton *)sender setImage:[NSImage imageNamed:@"NSStopProgressTemplate"]];
		currentPlay = sender;
	}
}

// Perform cleanup when the application terminates
- (void) applicationWillTerminate:(NSNotification*)notification
{	
	[icon1 release];
	[icon2 release];
	[icon3 release];
	[icon4 release];
	[icon5 release];
	[icon11 release];
	[icon21 release];
	[icon31 release];
	[icon41 release];
	[icon51 release];
	[_token release];
	if (sound) {
		[sound stop];
		[sound release];
		sound = nil;
	}
	if (friendsArray) {
		[friendsArray release];
	}
	if (newsArray) {
		[newsArray release];
	}
	if (wallArray) {
		[wallArray release];
	}
	if (messageArray) {
		[messageArray release];
	}
	if (audioArray) {
		[audioArray release];
	}
	if (nil!=self.updateTimer) {
		[self.updateTimer invalidate];
		[self.updateTimer release];
		self.updateTimer = nil;
	}
}

- (IBAction) performClick1:(id)sender
{
	[button1 setImage:icon11];
	[button2 setImage:icon2];
	[button3 setImage:icon3];
	[button4 setImage:icon4];
	[button5 setImage:icon5];
	
	if (!newsArray) [self openNews];

	TableDataSource *table = (id)_wall.dataSource;
	[table setTableSet:newsArray];
	table.choice = kNews;
	[_wall reloadData];
}

- (IBAction) performClick2:(id)sender
{
	[button2 setImage:icon21];
	[button1 setImage:icon1];
	[button3 setImage:icon3];
	[button4 setImage:icon4];
	[button5 setImage:icon5];
	
	if (!messageArray) [self openMessage];

	TableDataSource *table = (id)_wall.dataSource;
	[table setTableSet:messageArray];
	table.choice = kMessages;
	[_wall reloadData];
}

- (IBAction) performClick3:(id)sender
{
	[button3 setImage:icon31];
	[button1 setImage:icon1];
	[button2 setImage:icon2];
	[button4 setImage:icon4];
	[button5 setImage:icon5];
	
	if (!wallArray) [self openWall];

	TableDataSource *table = (id)_wall.dataSource;
	[table setTableSet:wallArray];
	table.choice = kNews;
	[_wall reloadData];
}

- (IBAction) performClick4:(id)sender
{
	[button4 setImage:icon41];
	[button1 setImage:icon1];
	[button2 setImage:icon2];
	[button3 setImage:icon3];
	[button5 setImage:icon5];
	
	if (!friendsArray) [self openFriends];

	TableDataSource *table = (id)_wall.dataSource;
	[table setTableSet:friendsArray];
	table.choice = kFriends;
	[_wall reloadData];
}

- (IBAction) performClick5:(id)sender
{
	[button5 setImage:icon51];
	[button1 setImage:icon1];
	[button2 setImage:icon2];
	[button3 setImage:icon3];
	[button4 setImage:icon4];
	
	if (!audioArray) [self openAudio];

	TableDataSource *table = (id)_wall.dataSource;
	[table setTableSet:audioArray];
	table.choice = kAudio;
	[_wall reloadData];
}

@end
