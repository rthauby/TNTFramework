//
//  TNTSplashScreen.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/21/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TNTSplashScreen : NSObject {
	UIImageView *splashImageView;
}

@property (retain, nonatomic) UIImageView *splashImageView;

- (TNTSplashScreen *)initWithImageNamed:(NSString *)imageName inView:(UIView *)view;
- (void)startupAnimationStartWithSplashName:(NSString *)splashname forView:(UIView *)mainView;

@end
