//
//  StudentDetailVC.h
//  UITableViewDemoProject
//

#import <UIKit/UIKit.h>

@interface StudentDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  NSMutableArray *data;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

- (IBAction)backButton:(id)sender;


@end
