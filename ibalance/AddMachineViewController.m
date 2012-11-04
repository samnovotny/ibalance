//
//  AddMachineViewController.m
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import "AddMachineViewController.h"

@interface AddMachineViewController ()

@end

@implementation AddMachineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNewMachine:(UIBarButtonItem *)sender {
    [self.machine setWithName:self.registration.text
                       weight:[self.bem.text floatValue]
                       moment:[self.arm.text floatValue]];
    [self.delegate saveMachineInfo:self.machine];
}

@end
