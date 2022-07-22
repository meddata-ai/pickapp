//
//  FindSenderViewController.h
//  PickApp
//
//  Created by Aakash on 19/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@import GooglePlaces;

#import <JTCalendar/JTCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindSenderViewController : UIViewController<GMSAutocompleteTableDataSourceDelegate, UISearchBarDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,JTCalendarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIImageView *accountBtn;
@property (weak, nonatomic) IBOutlet UITextField *departField;
@property (weak, nonatomic) IBOutlet UITextField *destField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITableView *senderList;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UIView *popdetail;

@property (weak, nonatomic) IBOutlet UILabel *departText;
@property (weak, nonatomic) IBOutlet UILabel *destText;
@property (weak, nonatomic) IBOutlet UILabel *feeText;
@property (weak, nonatomic) IBOutlet UILabel *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *emailText;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UIImageView *addSender;
@property (weak, nonatomic) IBOutlet UITableView *resulttableview;
@property (weak, nonatomic) IBOutlet UITableView *destintableview;


@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@end

NS_ASSUME_NONNULL_END
