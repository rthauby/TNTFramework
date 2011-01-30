//
//  TNTNavBar.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTNavBar.h"

@implementation TNTNavBar

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

// Adding the navigation bar background
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	UIImage *backdrop = [UIImage imageNamed:@"navBar.png"];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawImage(context, CGRectMake(0,0,backdrop.size.width, backdrop.size.height), backdrop.CGImage);
}

- (void)dealloc {
    [super dealloc];
}

@end
