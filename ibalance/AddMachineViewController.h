//
//  AddMachineViewController.h
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Machine.h"

@protocol AddMachineViewControllerDelegate

- (void) saveMachineInfo:(Machine *) machine;

@end

@interface AddMachineViewController : UIViewController

@property (strong, nonatomic) Machine *machine;
@property (assign, nonatomic) id <AddMachineViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *registration;
@property (weak, nonatomic) IBOutlet UITextField *bem;
@property (weak, nonatomic) IBOutlet UITextField *arm;

- (IBAction)saveNewMachine:(UIBarButtonItem *)sender;

@end
