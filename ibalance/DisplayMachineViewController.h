//
//  DisplayMachineViewController.h
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Machine.h"

@interface DisplayMachineViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Machine *machine;

@end
