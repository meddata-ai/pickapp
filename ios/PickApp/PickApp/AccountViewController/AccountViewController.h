//
//  AccountViewController.h
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIImageView *editNameicon;
@property (weak, nonatomic) IBOutlet UIImageView *editNoIcon;
@property (weak, nonatomic) IBOutlet UIImageView *showhideEmail;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabelf;
@property (weak, nonatomic) IBOutlet UILabel *poplabel;
@property (weak, nonatomic) IBOutlet UIView *popview;

@property (weak, nonatomic) IBOutlet UIView *updateView;
@property (weak, nonatomic) IBOutlet UITextField *editableField;
@end

NS_ASSUME_NONNULL_END
