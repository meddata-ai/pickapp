//
//  SettingsViewController.h
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *helpView;
@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UIImageView *logoutBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *notfyView;
@property (weak, nonatomic) IBOutlet UIView *logoutview;
@property (weak, nonatomic) IBOutlet UIImageView *logoutys;
@property (weak, nonatomic) IBOutlet UIImageView *logoutno;
@property (weak, nonatomic) IBOutlet UIImageView *logoutcrss;

@end

NS_ASSUME_NONNULL_END
