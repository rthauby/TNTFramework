//
//  TNTSplashScreen.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/21/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTSplashScreen.h"


@implementation TNTSplashScreen

@synthesize splashImageView;

- (TNTSplashScreen *)initWithImageNamed:(NSString *)imageName inView:(UIView *)view {
	[self startupAnimationStartWithSplashName:imageName forView:view];
	return self;
}

- (void)startupAnimationStartWithSplashName:(NSString *)splashname forView:(UIView *)mainView {
	UIImage *splashviewImage = [UIImage imageNamed:splashname];
	splashImageView = [[UIImageView alloc] initWithFrame:mainView.frame];
	splashImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight, UIViewAutoresizingFlexibleWidth;
	splashImageView.contentMode =  UIViewContentModeCenter;
	splashImageView.image = splashviewImage;
	
	[mainView addSubview:splashImageView];
	[mainView bringSubviewToFront:splashImageView];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:2];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:mainView cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone)];
	splashImageView.alpha = 0.0;
	[UIView commitAnimations];
	[splashviewImage release];
}

-(void)startupAnimationDone {
	[splashImageView removeFromSuperview];
	splashImageView = nil;
	[splashImageView release];
}

-(void)dealloc {
	[splashImageView release];
	[super dealloc];
}

@end
