//
//  HelpCenterViewController.h
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UIView *privacyView;
@end

NS_ASSUME_NONNULL_END
