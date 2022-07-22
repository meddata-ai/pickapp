//
//  BottomViewController.h
//  PickApp
//
//  Created by Aakash on 19/11/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BottomViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *senderListbtn;
@property (weak, nonatomic) IBOutlet UIImageView *deliverlistBtn;
@property (weak, nonatomic) IBOutlet UIImageView *favlistBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sendslctline;
@property (weak, nonatomic) IBOutlet UIImageView *courierslctdlin;
@property (weak, nonatomic) IBOutlet UIImageView *favoritslctdline;

@end

NS_ASSUME_NONNULL_END
