//
//  TNTHttpImage.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNTHttpImage : NSObject {
	NSString *url;
	UIImage *imageObj;
	UIImageView *imageview;
	NSMutableData *imgData;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImage *imageObj;
@property (nonatomic, retain) UIImageView *imageview;
@property (nonatomic, retain) NSMutableData *imgData;

- (void)loadImageFromUrl:(NSString *)_url forImageView:(UIImageView *)_imageview;
- (void)loadImage;
- (void)displayImage;
//- (void) cacheImage: (NSString *) ImageURLString;
//- (UIImage *) getCachedImage: (NSString *) ImageURLString;

@end
