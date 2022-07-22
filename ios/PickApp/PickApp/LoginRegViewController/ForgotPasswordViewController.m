//
//  ForgotPasswordViewController.m
//  PickApp
//
//  Created by Aakash on 07/12/21.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
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
- (IBAction)submitAct:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
     if(([emailTest evaluateWithObject:self.emailField.text] == NO) || (self.emailField == nil || [self.emailField.text isEqualToString:@""]) )
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter correct email" type:RMessageTypeError customTypeName:nil callback:nil];
    }
   else{
        [self webserviceCallForForgotPassword];
    }
}
- (void) webserviceCallForForgotPassword
{
   
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

//    senderdata= [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
  
    [dict setValue:@"forgotPassword" forKey:@"key"];
    [dict setValue:self.emailField.text forKey:@"email"];

//https://deckwebtech.com/pickapp_demo/addingData.php?id=addSender&apiKey=YavK2cw5ZoBEqTf6W0HCG1OiXx9d7Jnu&departure=&destination=&date=&fee=&comment=&phone=&email=&viewEmail=True&viewPhone=false
    NSLog(@"%@%@ %@",kBaseURL,kBaseURLSignInAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLSignInAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [activityIndicatorView stopAnimating];
               if([[responseObject valueForKey:@"status"]intValue]>0)
               {
                   [RMessage showNotificationInViewController:self title:@"Success" subtitle:[responseObject valueForKey:@"message"] type:RMessageTypeSuccess customTypeName:nil callback:nil];
               }
               else
               {
                   [activityIndicatorView stopAnimating];
                    [RMessage showNotificationInViewController:self title:@"Error" subtitle:[responseObject valueForKey:@"message"] type:RMessageTypeError customTypeName:nil callback:nil];
               }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
          [activityIndicatorView stopAnimating];
                NSLog(@"%@",error);
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  correct details" type:RMessageTypeError customTypeName:nil callback:nil];
    }];
}
@end
