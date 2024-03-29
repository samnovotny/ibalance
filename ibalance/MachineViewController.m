//
//  MachineViewController.m
//  ibalance
//
//  Created by Sam on 04/11/2012.
//  Copyright (c) 2012 Sam Novotny. All rights reserved.
//

#import "MachineViewController.h"
#import "AddMachineViewController.h"
#import "DisplayMachineViewController.h"

@interface MachineViewController ()

@property (strong, nonatomic) NSMutableArray *listOfachines;
@property (assign, nonatomic) int selectedRow;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) UITapGestureRecognizer *tabRecogniser;

@end

@implementation MachineViewController 

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"iBalance";
    [self restoreState];
    self.tabRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self.view addGestureRecognizer:self.tabRecogniser];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self tapHandler:nil];
}

- (void)tapHandler:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"acceptedTerms"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Please note, this utility is intended as quick reference to checking weight and balance calculations for a R44 Raven II. It should not be used for critical weight and balance calculations. By accepting these terms you agree to accept the risk of inaccuracies."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Accept", nil];
        [alert show];
    }
    else {
        self.addButton.enabled = YES;
        [self.view removeGestureRecognizer:self.tabRecogniser];
    }    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"acceptedTerms"];
        self.addButton.enabled = YES;
        [self.view removeGestureRecognizer:self.tabRecogniser];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.listOfachines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MACHINE" forIndexPath:indexPath];
    Machine *machine = [self.listOfachines objectAtIndex:indexPath.row];
    
    cell.textLabel.text = machine.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", machine.moment];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.listOfachines removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveState];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AddMachineViewController class]]) {
        AddMachineViewController *amvc = (AddMachineViewController *) segue.destinationViewController;
        amvc.delegate = self;
        if ([segue.identifier isEqualToString:@"EDITMACHINE"]) {
            amvc.machine = [self.listOfachines objectAtIndex:self.selectedRow];
        }
        else {
            amvc.machine = nil;
        }
    }
    else {
        DisplayMachineViewController *dmvc = (DisplayMachineViewController *) segue.destinationViewController;
        dmvc.machine = [self.listOfachines objectAtIndex:self.selectedRow];
    }
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"EDITMACHINE" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"DISPLAYMACHINE" sender:self];
}

#pragma mark - Add machine delegate

- (void)saveMachineInfo:(Machine *)machine {
    if ([self.listOfachines indexOfObject:machine] == NSNotFound) {
        [self.listOfachines addObject:machine];
        [self saveState];
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

#pragma mark - save / restore array of machines

- (NSString *) dataFilePath {
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [path objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"machines"];
}

- (void)saveState {
    NSData *dataToSave = [NSKeyedArchiver archivedDataWithRootObject:_listOfachines];
    [dataToSave writeToFile:[self dataFilePath] atomically:YES];
}

- (void)restoreState {
    NSData *storedData = [NSData dataWithContentsOfFile:[self dataFilePath]];
    if (storedData == nil) {
        _listOfachines = [[NSMutableArray alloc] init];
    }
    else {
        _listOfachines = [NSKeyedUnarchiver unarchiveObjectWithData:storedData];
    }
}

@end
