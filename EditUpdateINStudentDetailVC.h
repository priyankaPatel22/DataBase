//
//  EditUpdateINStudentDetailVC.h
//  UITableViewDemoProject


#import <UIKit/UIKit.h>
#import "AGMedallionView.h"
@interface EditUpdateINStudentDetailVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AGMedallionView *medallionView;
}
@property (nonatomic, strong) IBOutlet AGMedallionView *medallionView;

@property (assign, nonatomic) bool whichOperation;
@property (assign, nonatomic) int idNo;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genVar;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) IBOutlet UITextView *txtAddress;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnUpload:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end
