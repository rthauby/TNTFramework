//
//  TNTToolTip.h
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

@interface TNTToolTip : UILabel {
	
	CGPoint initialPos;

}

@property CGPoint initialPos;

-(void)fadeIn;
-(void)fadeOut;
-(void)moveX:(int)xTrans andY:(int)yTrans;

@end
