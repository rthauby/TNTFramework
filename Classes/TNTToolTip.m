//
//  TNTToolTip.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTToolTip.h"


@implementation TNTToolTip
@synthesize initialPos;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 69, 71);
		self.alpha = 0.0;
    }
    return self;
}

-(void)awakeFromNib{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 69, 71);
	self.initialPos = CGPointMake(self.frame.origin.x, self.frame.origin.y);
	self.alpha = 0.0;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	UIImage *backdrop = [UIImage imageNamed:@"tooltip.png"];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawImage(context, CGRectMake(0,0,backdrop.size.width, backdrop.size.height), backdrop.CGImage);
	[super drawRect:rect];
}

-(void)fadeIn{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	
	self.alpha = 1.0;
	
	[UIView commitAnimations];
}

-(void)fadeOut{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	
	self.alpha = 0.0;
	
	[UIView commitAnimations];
}

-(void)moveX:(int)xTrans andY:(int)yTrans{
	self.frame = CGRectMake(self.initialPos.x + xTrans, self.initialPos.y + yTrans, self.frame.size.width, self.frame.size.height);
}

- (void)dealloc {
    [super dealloc];
}
@end
