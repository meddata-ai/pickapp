//
//  FavoriteListViewController.m
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import "FavoriteListViewController.h"

@interface FavoriteListViewController ()
{
    BottomViewController *menuviewc;
}
@end

@implementation FavoriteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuviewc =  [[BottomViewController alloc] init];
    UITapGestureRecognizer *accountBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountBtnAct)];
    accountBtn.numberOfTapsRequired = 1;
    [self.accountBtn addGestureRecognizer:accountBtn];
    self.accountBtn.userInteractionEnabled = YES;
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
}
- (void)accountBtnAct {
    SettingsViewController *homemain=[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
-(void)viewDidLayoutSubviews
{
   menuviewc.view.frame = self.bottomMenu.bounds;
   [self.bottomMenu addSubview:menuviewc.view];
    
    menuviewc.favoritslctdline.hidden=FALSE;

    
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
- (void)deliverListAct {
    FindCourierViewController *homemain=[[FindCourierViewController alloc]initWithNibName:@"FindCourierViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)senderListAct {
    FindSenderViewController *homemain=[[FindSenderViewController alloc]initWithNibName:@"FindSenderViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)favListAct {
//    FavoriteListViewController *homemain=[[FavoriteListViewController alloc]initWithNibName:@"FavoriteListViewController" bundle:nil];
//   // homemain.requesttype=@"signup";
//    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)backActn:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
