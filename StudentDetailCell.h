//
//  StudentDetailCell.h
//  UITableViewDemoProject


#import <UIKit/UIKit.h>
#import "AGMedallionView.h"

@interface StudentDetailCell : UITableViewCell
{
    AGMedallionView *medallionView;
}
@property (nonatomic, strong) IBOutlet AGMedallionView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *txtName;
@property (strong, nonatomic) IBOutlet UILabel *txtGender;
@property (strong, nonatomic) IBOutlet UILabel *txtCity;
@property (strong, nonatomic) IBOutlet UITextView *txtAddress;

//txtAddress
//@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end
