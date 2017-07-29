//
//  Demo.h
//  CoreDataSampleProject
/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface DeviceTVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblView;

- (IBAction)backClick:(id)sender;
@end
