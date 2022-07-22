//
//  NotificationViewController.m
//  PickApp
//
//  Created by Aakash Singh on 04/03/22.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()
{
    BottomViewController *menuviewc;
}
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    menuviewc =  [[BottomViewController alloc] init];

    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *accountView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountViewAct)];
    accountView.numberOfTapsRequired = 1;
    [self.accountBtn addGestureRecognizer:accountView];
    self.accountBtn.userInteractionEnabled = YES;

    [self.accntswitch setOn:[[[NSUserDefaults standardUserDefaults] stringForKey:@"acntswitchact"] boolValue] animated:YES];
    
    [self.roomswitch setOn:[[[NSUserDefaults standardUserDefaults] stringForKey:@"roomswtchact"] boolValue] animated:YES];
    [self.systemswitch setOn:[[[NSUserDefaults standardUserDefaults] stringForKey:@"systswtchact"] boolValue] animated:YES];

}
-(void)viewDidLayoutSubviews
{
   menuviewc.view.frame = self.bottomMenu.bounds;
   [self.bottomMenu addSubview:menuviewc.view];
    
   
    
    UITapGestureRecognizer *senderListbtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(senderListAct)];
    senderListbtn.numberOfTapsRequired = 1;
           [menuviewc.senderListbtn addGestureRecognizer:senderListbtn];
           menuviewc.senderListbtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *deliverlistBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deliverListAct)];
    deliverlistBtn.numberOfTapsRequired = 1;
           [menuviewc.deliverlistBtn addGestureRecognizer:deliverlistBtn];
           menuviewc.deliverlistBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *favlistBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favListAct)];
    favlistBtn.numberOfTapsRequired = 1;
           [menuviewc.favlistBtn addGestureRecognizer:favlistBtn];
           menuviewc.favlistBtn.userInteractionEnabled = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)backActn:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)accountViewAct {
    AccountViewController *homemain=[[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}

- (void)deliverListAct {
    FindCourierViewController *homemain=[[FindCourierViewController alloc]initWithNibName:@"FindCourierViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)senderListAct {
    FindSenderViewController *homemain=[[FindSenderViewController alloc]initWithNibName:@"FindSenderViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)favListAct {
    FavoriteListViewController *homemain=[[FavoriteListViewController alloc]initWithNibName:@"FavoriteListViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (IBAction)acntswitchact:(id)sender {
    UISwitch *switchControl = sender;

    NSString *value = [[NSString alloc] initWithFormat:@"%@",switchControl.isOn?@"YES":@"NO"];

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:@"acntswitchact"];
    [userDefault synchronize];
}
- (IBAction)roomswtchact:(id)sender {
    UISwitch *switchControl = sender;

    NSString *value = [[NSString alloc] initWithFormat:@"%@",switchControl.isOn?@"YES":@"NO"];

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:@"roomswtchact"];
    [userDefault synchronize];
}
- (IBAction)systswtchact:(id)sender {
    UISwitch *switchControl = sender;

    NSString *value = [[NSString alloc] initWithFormat:@"%@",switchControl.isOn?@"YES":@"NO"];

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:@"systswtchact"];
    [userDefault synchronize];
}
- (Boolean)boolValueToString:(NSString *)theBool {
    if ([theBool isEqualToString:@"YES"])
        return YES; // can change to No, NOOOOO, etc
    else
        return NO; // can change to YEAH, Yes, YESSSSS etc
}
@end
