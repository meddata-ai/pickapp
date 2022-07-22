//
//  DashboardViewController.h
//  PickApp
//
//  Created by Aakash on 18/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DashboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *sendRqst;
@property (weak, nonatomic) IBOutlet UIImageView *delvryRqst;
@property (weak, nonatomic) IBOutlet UIView *bottomMenu;
@property (weak, nonatomic) IBOutlet UIImageView *accountBtn;

@end

NS_ASSUME_NONNULL_END
