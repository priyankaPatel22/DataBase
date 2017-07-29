//
//  StudentDetailCell.m
//  UITableViewDemoProject


#import "StudentDetailCell.h"

@implementation StudentDetailCell
@synthesize  txtName=_txtName;
@synthesize txtGender=_txtGender;
@synthesize txtCity=_txtCity;
@synthesize txtAddress=_txtAddress;
@synthesize imgView=_imgView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
