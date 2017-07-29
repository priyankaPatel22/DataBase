//
//  EditUpdateINStudentDetailVC.m
//  UITableViewDemoProject


#import "EditUpdateINStudentDetailVC.h"
#import "Database.h"

#import "AGMedallionView.h"

@interface EditUpdateINStudentDetailVC ()
@end

@implementation EditUpdateINStudentDetailVC
@synthesize medallionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    
    if (_whichOperation==0)
    {
        NSString *query=[NSString stringWithFormat:@"SELECT * FROM student WHERE id=%d",_idNo+1];
        NSArray *data1=[[Database shareDatabase] SelectAllFromTable:query];
        
        _txtName.text=[[data1 objectAtIndex:0]  valueForKey:@"name"];
        _txtCity.text=[[data1 objectAtIndex:0]  valueForKey:@"city"];
        _txtAddress.text=[[data1 objectAtIndex:0]  valueForKey:@"address"];
        [_genVar setSelectedSegmentIndex: [[[data1 objectAtIndex:0]  valueForKey:@"gender"] isEqualToString:@"Male"]?0:1];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[[data1 objectAtIndex:0] valueForKey:@"photo"]];
    
        self.medallionView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:dataPath]];
    }
    else
    {
        self.medallionView.image = [UIImage imageNamed:@"userDefault.png"];
    }
}
- (void)medallionDidTap:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tap" message:@"Medallion has been tapped." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender
{
    if (_whichOperation==1)
    {
        NSLog(@"edit.......... %d",_whichOperation);
        
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *Path = [NSString stringWithFormat:@"%@/image_%d.png",dir,_idNo+1];
        
        NSFileManager *checkFile=[NSFileManager defaultManager];
        
        if (![checkFile fileExistsAtPath:Path])
        {
            NSData *data = [NSData dataWithData:UIImagePNGRepresentation(self.medallionView.image)];
            [data writeToFile:Path atomically:YES];
        }
        
        NSData *data = [NSData dataWithData:UIImagePNGRepresentation(self.medallionView.image)];
        [data writeToFile:Path atomically:YES];
        
        NSString *pngPath = [NSString stringWithFormat:@"image_%d.png",_idNo+1];
        NSString *query_in=[NSString stringWithFormat:@"INSERT INTO student (name,gender,city,address,photo) VALUES (\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')",_txtName.text,_genVar.selectedSegmentIndex==0?@"Male":@"Female",_txtCity.text,_txtAddress.text,pngPath];
        
        [[Database shareDatabase] Insert:query_in];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        NSLog(@"update......... %d",_whichOperation);
        
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *Path = [NSString stringWithFormat:@"%@/image_%d.png",dir,_idNo+1];
        
        NSData *data = [NSData dataWithData:UIImagePNGRepresentation(self.medallionView.image)];
        [data writeToFile:Path atomically:YES];
        
        NSString *pngPath = [NSString stringWithFormat:@"image_%d.png",_idNo+1];
        
        NSString *query_in=[NSString stringWithFormat:@"UPDATE student SET name=\'%@\',gender=\'%@\',city=\'%@\',address=\'%@\',photo=\'%@\' WHERE id = %d",_txtName.text,_genVar.selectedSegmentIndex==0?@"Male":@"Female",_txtCity.text,_txtAddress.text,pngPath,_idNo+1];
        
        [[Database shareDatabase] Update:query_in];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)btnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnUpload:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark - Delegate meth
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imgView.image = chosenImage;
    self.medallionView.image=chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
#pragma mark - Delegate meth for text field
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"."]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
