//
//  TNTVBox.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTVBox.h"


@implementation TNTVBox

@synthesize resizesSelf;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.clearsContextBeforeDrawing = YES;
		self.opaque = NO;
    }
    return self;
}

- (void)awakeFromNib{
	self.clearsContextBeforeDrawing = YES;
	self.opaque = NO;
	self.resizesSelf = NO;
	[self setNeedsLayout];
}

- (void)layoutSubviews{
	float yPos = 0.0;
	for (UIView *view in self.subviews) {
		view.frame = CGRectMake(view.frame.origin.x, yPos, view.frame.size.width, view.frame.size.height);
		yPos += view.frame.size.height;
	}
	if(resizesSelf)
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, yPos);
	[self.superview setNeedsLayout];
}

- (void)dealloc {
    [super dealloc];
}

@end
