//
//  Const.h
//  Vkontaktik
//
//  Created by Andrey Andreev on 2/2/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#ifndef Vkontaktik_Const_h
#define Vkontaktik_Const_h

#define USERNAME @"user_name"
#define USERPIC @"user_pic"
#define ARTIST @"artist"
#define TITLE @"title"
#define AUDIO @"audioArray"
#define URL @"url"
#define DURATION @"duration"
#define ONLINE @"online"
//#define TIMEMESSAGE @"time"
#define MESSAGE @"message"
#define READSTATE @"read_state"
#define UID @"uid"
#define DATEMESSAGE @"dateMessage"
#define GROUPPIC @"groupPic"
#define GROUPNAME @"groupName"
#define ATTACHMENTSPHOTO @"attachmentsPhoto"

typedef enum {kFriends, kWall, kAudio, kMessages, kNews} TypeTable;

enum TypeNewsFlags {
	// User
    kNewsType1			= 1 << 0, // Текст
    kNewsType2			= 1 << 1, // Текст + картинка
    kNewsType3			= 1 << 2, // Картинка
    kNewsType4			= 1 << 3, // Текст + видео
    kNewsType5			= 1 << 4, // Видео
    kNewsType6			= 1 << 5, // Текст + аудио // Размер 
    kNewsType7			= 1 << 6, // Аудио
	
	kNewsType8			= 1 << 7, // Текст + картинка + аудио
	kNewsType9			= 1 << 8, // Картинка + аудио
	kNewsType10			= 1 << 9, // Текст + видео + аудио
	kNewsType11			= 1 << 10,// Видео + аудио 
	
	// Группа
    kNewsTypeG1			= 1 << 11,// Группа + Текст 
    kNewsTypeG2			= 1 << 12,// Группа + Текст + картинка 
    kNewsTypeG3			= 1 << 13,// Группа + Картинка
    kNewsTypeG4			= 1 << 14,// Группа + Текст + видео
    kNewsTypeG5			= 1 << 15,// Группа + Видео
    kNewsTypeG6			= 1 << 16,// Группа + Текст + аудио
    kNewsTypeG7			= 1 << 17,// Группа + Аудио
	
	kNewsTypeG8			= 1 << 18,// Группа + Текст + картинка + аудио
	kNewsTypeG9			= 1 << 19,// Группа + Картинка + аудио
	kNewsTypeG10		= 1 << 20,// Группа + Текст + видео + аудио
	kNewsTypeG11		= 1 << 21,// Группа + Видео + аудио
	
	// Линк
    kNewsTypeL1			= 1 << 22,
    kNewsTypeL2			= 1 << 23,
    kNewsTypeL3			= 1 << 24,
    kNewsTypeL4			= 1 << 25,
	kNewsTypeL5			= 1 << 26,
	kNewsTypeL6			= 1 << 27,
	kNewsTypeL7			= 1 << 28,
	
	// Группа + Линк
	kNewsTypeGL1		= 1 << 29,
	kNewsTypeGL2		= 1 << 30,
	kNewsTypeGL3		= 1 << 31,
	kNewsTypeGL4		= 1 << 32,
	kNewsTypeGL5		= 1 << 33,
	kNewsTypeGL6		= 1 << 34,
	kNewsTypeGL7		= 1 << 35
} TypeNews;

#endif
