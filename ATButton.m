//
//  ATButton.m
//  Vkontaktik
//
//  Created by Andrey Andreev on 3/9/12.
//  Copyright (c) 2012 Andy Apps. All rights reserved.
//

#import "ATButton.h"

@implementation ATButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		point = NSMakePoint(0, 0);
    }
    
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
    point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    [super mouseDown:theEvent];
}

/*- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}*/

@end
