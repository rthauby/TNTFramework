//
//  TNTGridView.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

@protocol TNTGridViewDelegate <NSObject>
@optional
- (id)setupCellForItem:(id)item;
- (void)tappedButton:(UIButton *)button withObject:(id)obj;
@end

@interface TNTGridView : UIView {
	
	CGRect originalFrame;
	NSMutableArray *data;
	int		columns;
	int		rows;
	float		cellWidth;
	float		cellHeight;
	int		indexOfObjectPlaced;
	id <TNTGridViewDelegate> delegate;
	BOOL transitioning;
	
}

@property (nonatomic, retain) NSMutableArray *data;
@property int columns, rows;
@property float cellWidth;
@property float cellHeight;
@property int indexOfObjectPlaced;
@property CGRect originalFrame;
@property (nonatomic, assign) id <TNTGridViewDelegate> delegate;

typedef enum {
    TNTGridViewSlideFromRight	=	0,
	TNTGridViewSlideFromLeft		=	1,
	TNTGridViewFadeIn			=	2
} TNTGridViewPresentationStyle;

- (id)initWithFrame:(CGRect)frame andColumns:(int)cols andRows:(int)rows;
- (id)initWithColumns:(int)colsCount andRows:(int)rowsCount;
- (void)reformatGridForColumns:(int)colsCount andRows:(int)rowsCount;
- (void)reformatGridForCellSize:(CGSize)size;
- (void)addItem:(NSObject *)item;
- (void)fromArray:(NSArray *)arr andPresentWithStyle:(TNTGridViewPresentationStyle)style;
- (void)cleanGridView;
- (void)presentGridView:(TNTGridViewPresentationStyle)style;
- (void)addCellView:(UIView *)cellView;
- (void)repositionFrame;
- (void)addAllCellViews;
- (void)calcCellSize;
- (void)resetOriginalFrame;
- (void)willRepositionAllCells;
- (void)repositionAllCells;
- (void)didRepositionAllCells;
- (void)traverseViews:(UIView *)view withSelector:(SEL)selector;

@end
