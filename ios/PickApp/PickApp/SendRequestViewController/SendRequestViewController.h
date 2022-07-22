//
//  SendRequestViewController.h
//  PickApp
//
//  Created by Aakash on 19/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+IODProfanityFilter.h"
#import "FlagPhoneNumber-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendRequestViewController : UIViewController<GMSAutocompleteTableDataSourceDelegate, UISearchBarDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UILabel *finddelver;
@property (weak, nonatomic) IBOutlet UIImageView *accountBtn;
@property (weak, nonatomic) IBOutlet UITextField *departField;
@property (weak, nonatomic) IBOutlet UITextField *destField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *feeField;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIImageView *sbmtbtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UITableView *resulttableview;
@property (weak, nonatomic) IBOutlet UITableView *destintableview;
@property (weak, nonatomic) IBOutlet UITextField *codetextfield;
@property (strong, nonatomic) IBOutlet UIPickerView *phonepicker;

@property (weak, nonatomic) IBOutlet UILabel *usdlbl;
- (IBAction)filter:(id)sender;

@end

NS_ASSUME_NONNULL_END
