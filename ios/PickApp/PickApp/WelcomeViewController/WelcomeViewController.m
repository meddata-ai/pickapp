//
//  WelcomeViewController.m
//  PickApp
//
//  Created by Aakash on 17/11/21.
//

#import "WelcomeViewController.h"
#import "DashboardViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginAct:(id)sender {
    DashboardViewController *homemain=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
  
    [self.navigationController pushViewController:homemain animated:YES];
}

@end
