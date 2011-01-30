//
//  TNTHttpImage.m
//  TNTFramework
//
//  Created by Rodrigo Thauby on 8/6/10.
//  Copyright 2010 TNTpixel. All rights reserved.
//

#import "TNTHttpImage.h"


@implementation TNTHttpImage

#define TMP NSTemporaryDirectory()

@synthesize url, imageObj, imageview, imgData;

- (void)loadImageFromUrl:(NSString *)_url forImageView:(UIImageView *)_imageview {
	self.imgData = [NSMutableData data];
	self.url = _url;
	self.imageview = _imageview;
	NSURLRequest *resourceURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] 
														cachePolicy:(NSURLRequestCachePolicy)NSURLRequestReturnCacheDataElseLoad 
													timeoutInterval:(NSTimeInterval)30.0];
	
	[[NSURLConnection alloc] initWithRequest:resourceURLRequest 
									 delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data {
    [self.imgData appendData:_data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	UIImage *img = [UIImage imageWithData:imgData];
	[self.imageview setImage:img];
	[imgData setData:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	[connection release];
}

- (void)loadImage {
	NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self url]]];
	self.imageObj = [[UIImage alloc] initWithData:imageData];
		
	[self performSelectorOnMainThread:@selector(displayImage) withObject:nil waitUntilDone:YES];
	[imageData release];
	[imageObj release];
}

- (void)displayImage {
	self.imageview.alpha = 0.0;
	self.imageview.image = self.imageObj;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.imageview cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	self.imageview.alpha = 1.0;
	[UIView commitAnimations];
	
	self = nil, [self release];
}

-(void)dealloc{
	self.imageObj =	nil,	[self.imageObj release];
	self.imageview = nil,	[self.imageview release];
	self.imgData = nil,		[self.imgData release];
	self.url = nil,			[self.url release];
 	
	[super dealloc];
}

@end
