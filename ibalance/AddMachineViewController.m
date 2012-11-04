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
    if (self.machine == nil) {
        self.machine = [[Machine alloc] init];
    }
    else {
        self.registration.text = self.machine.name;
        self.bem.text = [NSString stringWithFormat:@"%.0f", self.machine.emptyWeight];
        self.arm.text = [NSString stringWithFormat:@"%.0f", self.machine.moment];
    }
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
