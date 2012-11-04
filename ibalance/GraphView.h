//
//  GraphView.h
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import <UIKit/UIKit.h>

#define X_MIN 89
#define X_MAX 105
#define X_RAN (X_MAX - X_MIN)
#define Y_MIN 1500
#define Y_MAX 2700
#define Y_RAN (Y_MAX - Y_MIN)

@interface GraphView : UIView

@property (assign, nonatomic) CGFloat lastY;
@property (assign, nonatomic) CGFloat armPlot;
@property (assign, nonatomic) CGFloat weightPlot;
@property (assign, nonatomic) CGFloat armPlotF;
@property (assign, nonatomic) CGFloat weightPlotF;

- (void) setArm:(float)a andWeight:(float)w forFuel:(BOOL) fuel;

@end
