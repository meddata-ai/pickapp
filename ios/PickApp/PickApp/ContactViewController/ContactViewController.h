//
//  ContactViewController.h
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UITextView *msgField;
@property (weak, nonatomic) IBOutlet UIImageView *frstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secndImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@end

NS_ASSUME_NONNULL_END
