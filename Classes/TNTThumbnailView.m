//
//  TNTThumbnailView.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 9/20/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTThumbnailView.h"

@implementation TNTThumbnailView

@synthesize numberOfItems, width, height, padding, delegate;

- (void)awakeFromNib {
	[self setUpInitialState];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setUpInitialState];
	}
	
	return self;
}

- (void)setUpInitialState {
	
	height = self.frame.size.height;
	width = height;
	self.alwaysBounceHorizontal = YES;
	self.padding = 5.0;
	
}

- (void)layoutThumbnails {
	
	// Clean first
	for (TNTIndexedImageView *view in [self subviews]) {
		[view removeFromSuperview];
		view = nil;
	}
	
	// Repopulate later
	self.contentSize = CGSizeMake((numberOfItems * width), height);
	for (int i=0; i<numberOfItems; i++) {
		TNTIndexedImageView *thumbnailImageView = [[TNTIndexedImageView alloc] initWithImage:[UIImage imageNamed:@"generic_cover.png"]];
		thumbnailImageView.index = i;
		thumbnailImageView.frame = CGRectMake((i * width), padding, width, height - (2 * padding));
		thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
		thumbnailImageView.userInteractionEnabled = YES;
		
		UITapGestureRecognizer *tap = [UITapGestureRecognizer alloc];
		[tap initWithTarget:self action:@selector(tapHandler:)];
		[thumbnailImageView addGestureRecognizer:tap];
		[tap release];
		
		[self addSubview:thumbnailImageView];
		[thumbnailImageView release];
	}
	
}

- (void)tapHandler:(UIGestureRecognizer *)tap {
	[delegate tappedThumbnail:(UIImageView *)tap.view];
}

- (void)setImage:(UIImage *)img atIndex:(int)index {
	UIImageView *imgView = [[self subviews] objectAtIndex:index];
	imgView.image = img;
}

- (void)removeImageAtIndex:(int)index {
	UIImageView *imgView = [[self subviews] objectAtIndex:index];
	[imgView removeFromSuperview];
	[self repositionSubviews];
}

- (void)repositionSubviews {
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	
	for (int i=0; i<[[self subviews] count]; i++) {
		TNTIndexedImageView *imgView = (TNTIndexedImageView *)[[self subviews] objectAtIndex:i];
		imgView.index = i;
		imgView.frame = CGRectMake((i * width), padding, width, height - (2 * padding));
	}	
	
	[UIView commitAnimations];
}

- (void)setNumberOfItems:(int)newNumberOfItems {
	numberOfItems = newNumberOfItems;
	[self layoutThumbnails];
}

- (void)dealloc {
	[delegate release];
    [super dealloc];
}


@end
