//
//  TNTSearchField.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/20/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTSearchField.h"


@implementation TNTSearchField

- (void)viewWillAppear {
	[self setUp];
}

- (void)awakeFromNib{
	[self setUp];
}

- (void)setUp {
//	UIImageView *searchLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wordpress.png"]];
//	[self setLeftView:searchLogo];
//	[self setLeftViewMode: UITextFieldViewModeAlways];
//	[searchLogo release];
	[self.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.layer setBorderWidth: 1.0];
    [self.layer setCornerRadius:15.5f];
    [self.layer setMasksToBounds:YES];
	self.clearButtonMode = UITextFieldViewModeAlways;
	
}

- (void)dealloc {
    [super dealloc];
}


@end
