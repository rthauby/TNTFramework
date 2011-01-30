//
//  TNTGridView.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTGridView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TNTGridView
@synthesize data;
@synthesize columns, rows;
@synthesize cellWidth;
@synthesize cellHeight;
@synthesize indexOfObjectPlaced;
@synthesize originalFrame;
@synthesize delegate;

- (void)dealloc {
	[data release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame andColumns:(int)colsCount andRows:(int)rowsCount {
	if ((self = [super initWithFrame:frame])) {
		[self initWithColumns:colsCount andRows:rowsCount];
    }
    return self;
}

- (id)initWithColumns:(int)colsCount andRows:(int)rowsCount {
	self.autoresizesSubviews = NO;
	self.cellWidth = 0.0;
	self.cellHeight = 0.0;
	self.columns = colsCount;
	self.rows = rowsCount;
	self.data = [NSMutableArray array];
	self.indexOfObjectPlaced = 0;
	self.originalFrame = self.frame;
	self.opaque = NO;
	
	return self;
}

#pragma mark - Data Provider Methods

- (void)addItem:(NSObject *)item {
	[self.data addObject:item];
	[self addCellView:[self.data lastObject]];
	self.indexOfObjectPlaced++;
}

- (void)fromArray:(NSArray *)arr andPresentWithStyle:(TNTGridViewPresentationStyle)style {
	[self.data removeAllObjects];
	[self.data addObjectsFromArray:arr];
	[self addAllCellViews];
	[self presentGridView:style];
}

#pragma mark - Self Data Preservation

- (void)reformatGridForColumns:(int)colsCount andRows:(int)rowsCount{
	self.rows = rowsCount;
	self.columns = colsCount;
	[self calcCellSize];
	[self resetOriginalFrame];
	[self willRepositionAllCells];
	[self repositionAllCells];
	[[self superview] setNeedsLayout];
}

- (void)reformatGridForCellSize:(CGSize)size{
	if ([data count] > 0) {
		
		// How many rows would I need to fit that many items at this size
		float maxColumns = floor(self.frame.size.width / size.width);
		float newColumns = maxColumns;
		float newRows = ceil((float)[data count] / maxColumns);
		
		// Adjusting the overall frame size based on the new cell size desired and the number of rows I need (width remains static)
		float newHeight = (newRows * size.height);
		//float deltaY = self.frame.size.height - newHeight;
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
		
		// Split the new frame into corresponding grid that we calculated
		[self reformatGridForColumns:newColumns andRows:newRows];
	}
}

- (void)calcCellSize {
	self.cellWidth = floor(self.frame.size.width / columns);
	self.cellHeight = floor(self.frame.size.height / rows);
}

#pragma mark - Drawing Methods

- (void)resetOriginalFrame{
	self.originalFrame = self.frame;
}

-(void)repositionFrame{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationDelegate:self];
	self.frame = self.originalFrame;
	self.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)traverseViews:(UIView *)view withSelector:(SEL)selector {
    for (UIView *subview in view.subviews)
    {
        [self traverseViews:subview withSelector:selector];
    }
	if ([view respondsToSelector:selector]) {
		[view performSelector:selector];
	}
}


- (void)willRepositionAllCells {
	[self traverseViews:self withSelector:(@selector(disableShadows))];
}

- (void)repositionAllCells{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didRepositionAllCells)];
	for (int i = 0; i < [[self subviews] count]; i++) {
		int x = (i % self.columns) * self.cellWidth;
		int y = floor(i / self.columns) * self.cellHeight;
		UIView *cell = (UIView *)[[self subviews] objectAtIndex:i];
		cell.frame = CGRectMake(x,y,self.cellWidth,self.cellHeight);
	}
	[UIView commitAnimations];
	
}

- (void)didRepositionAllCells{
	[self traverseViews:self withSelector:(@selector(enableShadows))];
}

- (void)cleanGridView{
	self.indexOfObjectPlaced = 0;
	for (UIView *view in self.subviews) {
		if ([view respondsToSelector:@selector(setDelegate:)]) {
			[view setDelegate:nil];
		}
		view.alpha = 0.0;
		[view removeFromSuperview];
		view = nil;
		[view release];
	}
}

- (void)presentGridView:(TNTGridViewPresentationStyle)style{
	float displace;
	switch (style) {
		case TNTGridViewSlideFromRight:
			displace = 200.0;
			break;
		case TNTGridViewSlideFromLeft:
			displace = -200.0;
			break;
		case TNTGridViewFadeIn:
			displace = 0.0;
			break;
		default:
			break;
	}
	self.alpha = 1.0;
	self.frame = CGRectMake(self.originalFrame.origin.x ,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
}

- (void)addAllCellViews{
	[self cleanGridView];
	[self calcCellSize];
	self.indexOfObjectPlaced = 0;
	for(id item in self.data){
		id preparedCellView = [delegate setupCellForItem:item];
		[self addCellView:preparedCellView];
		self.indexOfObjectPlaced++;
	}
	[self.data removeAllObjects];
}

- (void)addCellView:(UIView *)cellView{
	// Positioning
	int x = (self.indexOfObjectPlaced % self.columns) * self.cellWidth;
	int y = floor(self.indexOfObjectPlaced / self.columns) * self.cellHeight;
	cellView.frame = CGRectMake(x,y,self.cellWidth,self.cellHeight);

	[self addSubview:cellView];
}
@end
