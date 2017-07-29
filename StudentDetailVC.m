//
//  StudentDetailVC.m
//  UITableViewDemoProject
//

#import "EditUpdateINStudentDetailVC.h"
#import "StudentDetailVC.h"
#import "Database.h"
#import "StudentDetailCell.h"

#import "UIViewController+MMDrawerController.h"

@interface StudentDetailVC ()
{
    
   // NSArray *keyVal;
}
@end

@implementation StudentDetailVC
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSString *query=[NSString stringWithFormat:@"SELECT * FROM student"];
    data=[[Database shareDatabase] SelectAllFromTable:query];
    
    
    NSLog(@"%@ == %d",data,[data count]);
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    NSString *query=[NSString stringWithFormat:@"SELECT * FROM student"];
    
    [data removeAllObjects];
    data=[[Database shareDatabase] SelectAllFromTable:query];
    
    [_tblView reloadData];
    
    NSLog(@"%@ == %d",data,[data count]);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    
    //////____________  Without Property _______________////////
    StudentDetailCell *cell = (StudentDetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"StudentDetailCell" owner:self options:nil];
        cell = (StudentDetailCell *)[nib objectAtIndex:0];
    }

    cell.txtName.text=[[data objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.txtGender.text=[[data objectAtIndex:indexPath.row] valueForKey:@"gender"];
    cell.txtCity.text=[[data objectAtIndex:indexPath.row] valueForKey:@"city"];
    cell.txtAddress.text=[[data objectAtIndex:indexPath.row] valueForKey:@"address"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[[data objectAtIndex:indexPath.row] valueForKey:@"photo"]];
    
    cell.imgView.image= [UIImage imageWithData:[NSData dataWithContentsOfFile:dataPath]];
    cell.imgView.borderColor=[UIColor blackColor];
    cell.imgView.borderWidth=2.0f;
    cell.imgView.shadowBlur=2.0f;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *query_in=[NSString stringWithFormat:@"DELETE FROM student WHERE id = %@",[[data objectAtIndex:indexPath.row] valueForKey:@"id"]];
        
        [[Database shareDatabase] Delete:query_in];
        
        NSString *query=[NSString stringWithFormat:@"SELECT * FROM student"];
        
        [data removeAllObjects];
        data=[[Database shareDatabase] SelectAllFromTable:query];
        
        [_tblView reloadData];
    }
}

#pragma mark - send data in segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditData"])
    {
        EditUpdateINStudentDetailVC *destViewController = segue.destinationViewController;
        destViewController.whichOperation = 1;
        destViewController.idNo=[data count];
    }
    else if ([[segue identifier] isEqualToString:@"UpdateData"])
    {
        EditUpdateINStudentDetailVC *destViewController = segue.destinationViewController;
        destViewController.whichOperation = 0;
        destViewController.idNo=[[self.tblView indexPathForSelectedRow] row];
    }
}


- (IBAction)backButton:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
@end
