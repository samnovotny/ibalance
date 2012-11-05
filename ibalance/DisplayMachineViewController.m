//
//  DisplayMachineViewController.m
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import "DisplayMachineViewController.h"
#import "GraphView.h"

@interface DisplayMachineViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pax;
@property (weak, nonatomic) IBOutlet UITextField *pilot;
@property (weak, nonatomic) IBOutlet UITextField *rearPaxLeft;
@property (weak, nonatomic) IBOutlet UITextField *rearPaxRight;
@property (weak, nonatomic) IBOutlet UITextField *fuel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLitres;
@property (weak, nonatomic) IBOutlet UILabel *mass;
@property (weak, nonatomic) IBOutlet UILabel *cog;
@property (strong, nonatomic) GraphView *graphView;
@property (assign, nonatomic) CGFloat lastY;
@property (weak, nonatomic) IBOutlet UISlider *fuelSlider;

@end

@implementation DisplayMachineViewController

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
    self.title = self.machine.name;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
    self.graphView = [[GraphView alloc] initWithFrame:CGRectMake(35, 185, 250, 180)];
    self.graphView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.graphView];
    [self sliderChanged:self.fuelSlider];
}


- (void) viewTapped:(id) sender {
    [self.pax resignFirstResponder];
    [self.pilot resignFirstResponder];
    [self.rearPaxLeft resignFirstResponder];
    [self.rearPaxRight resignFirstResponder];
    [self.fuel resignFirstResponder];
    [self calculate];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.fuel) {
        int v = textField.text.intValue;
        if (v > 49) {
            v = 49;
            textField.text = [NSString stringWithFormat:@"%d", v];
        }
        self.fuelSlider.value = v;
    }
    else {
        int v = textField.text.intValue;
        if (v > 300) {
            v = 300;
            textField.text = [NSString stringWithFormat:@"%d", v];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Calculations

- (void) calculate {
	
	float weight, moment;
	
	weight	= self.machine.emptyWeight
    + self.pilot.text.intValue
    + self.pax.text.intValue
    + self.rearPaxRight.text.intValue
    + self.rearPaxLeft.text.intValue;
	
	moment	= self.machine.moment
    + (self.pilot.text.intValue * self.machine.armFrontPax)
    + (self.pax.text.intValue * self.machine.armFrontPax)
    + (self.rearPaxRight.text.intValue * self.machine.armRearPax)
    + (self.rearPaxLeft.text.intValue * self.machine.armRearPax);
	
	[self.graphView setArm:(moment / weight) andWeight:weight forFuel:FALSE];
	
	weight  = weight + (self.fuel.text.intValue * 6);
	moment  = moment
    + (self.fuel.text.intValue * 6 * 30.6 / 48.9 * self.machine.armMainFuel)
    + (self.fuel.text.intValue * 6 * 18.3 / 48.9 * self.machine.armAuxFuel);
    
    self.mass.text =[NSString stringWithFormat:@"%5.0f lb", weight];
	if (weight > self.machine.maxWeight) {
		self.mass.textColor = [UIColor redColor];
	}
	else {
		self.mass.textColor = [UIColor blackColor];
	}
    
	self.cog.text = [NSString stringWithFormat:@"%3.1f\"", (moment / weight)];
    self.fuelLitres.text = [NSString stringWithFormat:@"%0.1f litres", self.fuel.text.intValue / 0.26417205 ];

	[self.graphView setArm:(moment / weight) andWeight:weight forFuel:TRUE];
	[self.graphView setNeedsDisplay];
}

//#pragma mark - Touch handling stuff
//
//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [[event allTouches] anyObject];
//	CGPoint location = [touch locationInView:self.view];
//	self.lastY = location.y;
//}
//
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [[event allTouches] anyObject];
//	CGPoint location = [touch locationInView:self.view];
//    int deltaY = location.y - self.lastY;
//
//	if (deltaY > 0) {
//        [self decrementFuel];
//	}
//	else if (deltaY < 0) {
//        [self incrementFuel];
//	}
//	self.lastY = location.y;
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//}
//
//- (void)decrementFuel {
//    int fuel = self.fuel.text.intValue;
//    if (fuel > 0) {
//        fuel--;
//        self.fuel.text = [NSString stringWithFormat:@"%d", fuel];
//        [self calculate];
//    }
//}
//
//- (void)incrementFuel {
//    int fuel = self.fuel.text.intValue;
//    if (fuel < 49) {
//        fuel++;
//        self.fuel.text = [NSString stringWithFormat:@"%d", fuel];
//        [self calculate];
//    }
//}

- (IBAction)sliderChanged:(UISlider *)sender {
    self.fuel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [self calculate];
}

@end
