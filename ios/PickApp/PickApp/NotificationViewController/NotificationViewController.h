//
//  NotificationViewController.h
//  PickApp
//
//  Created by Aakash Singh on 04/03/22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AccountViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIImageView *accountBtn;
@property (weak, nonatomic) IBOutlet UISwitch *accntswitch;
@property (weak, nonatomic) IBOutlet UISwitch *roomswitch;
@property (weak, nonatomic) IBOutlet UISwitch *systemswitch;

@end

NS_ASSUME_NONNULL_END
