//
//  ForgotPasswordViewController.h
//  PickApp
//
//  Created by Aakash on 07/12/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgotPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

NS_ASSUME_NONNULL_END
