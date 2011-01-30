//
//  TNTThumbnailView.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 9/20/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNTThumbnailViewDelegate <NSObject>
@optional
- (void)tappedThumbnail:(UIImageView *)thumbnail;
@end

@interface TNTThumbnailView : UIScrollView {
	int numberOfItems;
	CGFloat height, width;
	CGFloat padding;
	id <TNTThumbnailViewDelegate> delegate;
}

- (void)setUpInitialState;
- (void)layoutThumbnails;
- (void)tapHandler:(UIGestureRecognizer *)tap;
- (void)setImage:(UIImage *)img atIndex:(int)index;
- (void)removeImageAtIndex:(int)index;
- (void)repositionSubviews;

@property int numberOfItems;
@property CGFloat height, width, padding;
@property (nonatomic, assign) id <TNTThumbnailViewDelegate> delegate;

@end
