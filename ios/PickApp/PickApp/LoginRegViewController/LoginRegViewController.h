//
//  LoginRegViewController.h
//  PickApp
//
//  Created by Aakash on 23/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AuthenticationServices/AuthenticationServices.h>

extern NSString* const setCurrentIdentifier;

NS_ASSUME_NONNULL_BEGIN

@interface LoginRegViewController : UIViewController<UITextFieldDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIScrollView *regView;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *regbtn;
@property (weak, nonatomic) IBOutlet UITextField *lemailfield;
@property (weak, nonatomic) IBOutlet UITextField *lpaswrdfield;
@property (weak, nonatomic) IBOutlet UIImageView *pswrdvisiblityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rpswrdvisiblityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rcpswrdvisiblityBtn;
@property (weak, nonatomic) IBOutlet UITextField *rpaswrdfield;
@property (weak, nonatomic) IBOutlet UITextField *rcpaswrdfield;
@property (weak, nonatomic) IBOutlet UITextField *rNamefield;
@property (weak, nonatomic) IBOutlet UITextField *rEmailfield;
@property (weak, nonatomic) IBOutlet UIImageView *googlesignin;
@property (weak, nonatomic) IBOutlet UIImageView *fblogin;
@property (weak, nonatomic) IBOutlet UIImageView *googlereg;
@property (weak, nonatomic) IBOutlet UIImageView *fbreg;
@property (weak, nonatomic) IBOutlet UIImageView *tutorialBtn;
@property (weak, nonatomic) IBOutlet UIView *tutorialView;
@property (weak, nonatomic) IBOutlet UIImageView *entrnceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *regimgbtn;
@property (weak, nonatomic) IBOutlet UIImageView *loginsbmtbtn;
@property (weak, nonatomic) IBOutlet UIImageView *regsubmtBtn;
@property (nonatomic, strong) UITextView *appleIDLoginInfoTextView;
@property (weak, nonatomic) IBOutlet ASAuthorizationAppleIDButton *appleIDButton;

@end

NS_ASSUME_NONNULL_END
