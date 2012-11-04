//
//  GraphView.m
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 2.0);
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	
	CGContextMoveToPoint(context, [self scaleX:92.0 forRect:rect], [self scaleY:1600 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:102.5 forRect:rect], [self scaleY:1600 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:102.5 forRect:rect], [self scaleY:2100 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:98.0 forRect:rect], [self scaleY:2500 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:93.0 forRect:rect], [self scaleY:2500 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:92.0 forRect:rect], [self scaleY:2300 forRect:rect]);
	CGContextAddLineToPoint(context, [self scaleX:92.0 forRect:rect], [self scaleY:1600 forRect:rect]);
	CGContextStrokePath(context);
	
//	assert(self.armPlot != 0.0);
    
	if (self.armPlot != 0.0) {
		CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
		CGRect dot = CGRectMake([self scaleX:self.armPlot forRect:rect]-5, [self scaleY:self.weightPlot forRect:rect]-5, 9, 9);
		CGContextAddEllipseInRect(context, dot);
		CGContextDrawPath(context, kCGPathFill);
		CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
		dot = CGRectMake([self scaleX:self.armPlotF forRect:rect]-5, [self scaleY:self.weightPlotF forRect:rect]-5, 9, 9);
		CGContextAddEllipseInRect(context, dot);
		CGContextDrawPath(context, kCGPathFill);
	}
}

- (float) scaleX:(float)x forRect:(CGRect) rect {
	
	float f = (x - X_MIN) / X_RAN * rect.size.width;
	return f;
}

- (float) scaleY:(float)y  forRect:(CGRect) rect {
	float f = (y - Y_MIN) / Y_RAN * rect.size.height;
	f = rect.size.height - f;
	return f;
}

- (void) setArm:(float)a andWeight:(float)w forFuel:(BOOL) fuel {
	if (fuel) {
		self.armPlotF = a;
		self.weightPlotF = w;
	}
	else {
		self.armPlot = a;
		self.weightPlot = w;
	}
}


@end
