//
//  TNTSplitVBox.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTSplitVBox.h"


@implementation TNTSplitVBox

int const bottomPadding = 20;

- (void)awakeFromNib{
	self.clearsContextBeforeDrawing = YES;
	self.opaque = NO;
	[self setNeedsLayout];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
	
	UIView *firstChild = [[self subviews] objectAtIndex:0];
	UIView *secondChild = [[self subviews] objectAtIndex:1];
	
	secondChild.frame = CGRectMake(secondChild.frame.origin.x, 
								   firstChild.frame.size.height + firstChild.frame.origin.y, 
								   secondChild.frame.size.width, 
								   self.frame.size.height - firstChild.frame.size.height - 10 - firstChild.frame.origin.y - bottomPadding);
}

- (void)dealloc {
    [super dealloc];
}

@end
