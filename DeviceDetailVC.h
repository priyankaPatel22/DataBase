//
//  DeviceDetailVC.h
//  CoreDataSampleProject


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DeviceDetailVC : UIViewController 

@property (strong) NSManagedObject *device;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

- (IBAction)tapCancel:(id)sender;
- (IBAction)tapSave:(id)sender;

@end
