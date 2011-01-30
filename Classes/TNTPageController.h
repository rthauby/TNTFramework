//
//  TNTPageController.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

@protocol TNTPageControllerDelegate <NSObject>
@optional
- (void)pageChangeHandler;
@end

@interface TNTPageController : UIControl {

	int currentPage;
	int numberOfPages;
	UILabel *currentPageDisplay;
	UISlider *pageSlider;
	id <TNTPageControllerDelegate> delegate;
	TNTToolTip *pageMarker;
}

@property int currentPage, numberOfPages;
@property (nonatomic, retain) IBOutlet UILabel *currentPageDisplay;
@property (nonatomic, retain) IBOutlet UISlider *pageSlider;
@property (nonatomic, assign) id <TNTPageControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet TNTToolTip *pageMarker;

- (IBAction)sliderIsChanging:(id)sender;
- (IBAction)sliderTouchUp:(id)sender;
- (IBAction)sliderTouchDown:(id)sender;

@end
