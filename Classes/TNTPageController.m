//
//  TNTPageController.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTPageController.h"


@implementation TNTPageController
@synthesize currentPage, numberOfPages, currentPageDisplay, pageSlider, delegate, pageMarker;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code;
    }
    return self;
}

- (void)awakeFromNib{
	self.currentPage = 0;
	self.numberOfPages = 0;
	self.currentPageDisplay.text = @"";
	self.hidden = YES;
	[self addObserver:self forKeyPath:@"numberOfPages" options:0 context:nil];
	[self addObserver:self forKeyPath:@"currentPage" options:0 context:nil];
	
	[self.pageSlider setThumbImage:[UIImage imageNamed:@"track_slider.png"] forState:UIControlStateNormal];
	[self.pageSlider setMinimumTrackImage:[[UIImage imageNamed:@"slider_track_1.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
	[self.pageSlider setMaximumTrackImage:[[UIImage imageNamed:@"slider_track_0.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	[pageSlider setMaximumValue:(float)(numberOfPages - 1)];
	[self setNeedsLayout];
}

- (void)relocateTooltip{
	float valuePerPixel = (pageSlider.maximumValue - pageSlider.minimumValue) / ([pageSlider trackRectForBounds:self.frame].size.width - 100);
	int xtrans = (int)((pageSlider.value / valuePerPixel) + 0.5f);
	[pageMarker moveX:xtrans andY:0];
}

- (int)sliderValueAsInt{
	return (int)(pageSlider.value + 0.5f);
}

- (IBAction)sliderIsChanging:(id)sender{
	[self relocateTooltip];
	int progressAsInt = [self sliderValueAsInt];
	self.currentPageDisplay.text = [NSString stringWithFormat:@"%d / %d",(progressAsInt + 1),self.numberOfPages];
	self.pageMarker.text = [NSString stringWithFormat:@"Page %d",(progressAsInt + 1)];
}

- (IBAction)sliderTouchUp:(id)sender{
	[pageMarker fadeOut];
	int progressAsInt = [self sliderValueAsInt];
	if((int)self.currentPage != (int)progressAsInt){
		self.currentPage = progressAsInt;
		[self.delegate pageChangeHandler];
	}
}

- (IBAction)sliderTouchDown:(id)sender{
	[self relocateTooltip];
	int progressAsInt = [self sliderValueAsInt];
	self.pageMarker.text = [NSString stringWithFormat:@"Page %d",(progressAsInt + 1)];
	[pageMarker fadeIn];
}

- (void)layoutSubviews {

	if(self.numberOfPages > 1){
		self.hidden = NO;
		self.currentPageDisplay.text = [NSString stringWithFormat:@"%d / %d", (self.currentPage + 1), self.numberOfPages];
		[self.pageSlider setValue:(self.currentPage) animated:YES];
	}
	else {
		self.hidden = YES;
	}
	
}

- (void)dealloc {
	[currentPageDisplay release];
	[pageSlider release];
	[pageMarker release];
    [super dealloc];
}
@end
