//
//  TNTStyledImageView.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/22/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTShadowedImageView.h"


@implementation TNTShadowedImageView

- (void)didMoveToWindow {
	[self enableShadows];
}

- (void)enableShadows {
	self.layer.shouldRasterize = YES;
	self.clipsToBounds = NO;
	self.layer.shadowOffset = CGSizeMake(0,2);
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = 0.75;
	self.layer.shadowRadius = 2.0;
}

- (void)disableShadows {
	self.layer.shadowColor = [UIColor clearColor].CGColor;
}

- (void)dealloc {
    [super dealloc];
}


@end
