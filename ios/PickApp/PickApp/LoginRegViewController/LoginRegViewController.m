//
//  LoginRegViewController.m
//  PickApp
//
//  Created by Aakash on 23/11/21.
//

#import "LoginRegViewController.h"
#import "DashboardViewController.h"
#import "ForgotPasswordViewController.h"

NSString* const setCurrentIdentifier = @"setCurrentIdentifier";

@interface LoginRegViewController ()
{
    GIDConfiguration *signInConfig;
    NSString *sname;
    NSString *semail;
}
@end

@implementation LoginRegViewController
@synthesize appleIDLoginInfoTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    signInConfig = [[GIDConfiguration alloc] initWithClientID:@"150455093751-mpohc50au6cvgq7udgs7i1v7migacr9e.apps.googleusercontent.com"];
    if (@available(iOS 13.0, *)) {
           [self observeAppleSignInState];
           [self setupUI];
       }
    // Do any additional setup after loading the view from its nib.
    
    self.regView.contentSize=CGSizeMake(self.regView.frame.size.width,self.regView.frame.size.height*2);
    self.regView.hidden=TRUE;
    self.loginbtn.backgroundColor=[UIColor whiteColor];
    [self.entrnceBtn setHighlighted:TRUE];
    self.regbtn.backgroundColor=[UIColor blackColor];
    [self.regimgbtn setHighlighted:FALSE];
    
    self.tutorialView.layer.cornerRadius=20.0f;
    
    self.lemailfield.layer.cornerRadius=5.0f;
    self.lemailfield.borderStyle=UITextBorderStyleNone;
    self.lemailfield.clipsToBounds=YES;
    self.lpaswrdfield.layer.cornerRadius=5.0f;
    self.lpaswrdfield.borderStyle=UITextBorderStyleNone;
    self.lpaswrdfield.clipsToBounds=YES;
    
    self.rEmailfield.layer.cornerRadius=5.0f;
    self.rEmailfield.borderStyle=UITextBorderStyleNone;
    self.rEmailfield.clipsToBounds=YES;
    self.rNamefield.layer.cornerRadius=5.0f;
    self.rNamefield.borderStyle=UITextBorderStyleNone;
    self.rNamefield.clipsToBounds=YES;
    self.rpaswrdfield.layer.cornerRadius=5.0f;
    self.rpaswrdfield.borderStyle=UITextBorderStyleNone;
    self.rpaswrdfield.clipsToBounds=YES;
    self.rcpaswrdfield.layer.cornerRadius=5.0f;
    self.rcpaswrdfield.borderStyle=UITextBorderStyleNone;
    self.rcpaswrdfield.clipsToBounds=YES;
    
    UITapGestureRecognizer *pswdvisiblitybtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginRightButton:)];
    pswdvisiblitybtn.numberOfTapsRequired = 1;
           [self.pswrdvisiblityBtn addGestureRecognizer:pswdvisiblitybtn];
           self.pswrdvisiblityBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rpswdvisiblitybtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pRightButton:)];
    rpswdvisiblitybtn.numberOfTapsRequired = 1;
           [self.rpswrdvisiblityBtn addGestureRecognizer:rpswdvisiblitybtn];
           self.rpswrdvisiblityBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rcpswdvisiblitybtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cpRightButton:)];
    rcpswdvisiblitybtn.numberOfTapsRequired = 1;
           [self.rcpswrdvisiblityBtn addGestureRecognizer:rcpswdvisiblitybtn];
           self.rcpswrdvisiblityBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *googlesigninbtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signIn:)];
    googlesigninbtn.numberOfTapsRequired = 1;
           [self.googlesignin addGestureRecognizer:googlesigninbtn];
           self.googlesignin.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *googlesigninbtnr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signIn:)];
    googlesigninbtnr.numberOfTapsRequired = 1;
           
    [self.googlereg addGestureRecognizer:googlesigninbtnr];
    self.googlereg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *fbloginbtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fblogIn:)];
    fbloginbtn.numberOfTapsRequired = 1;
           [self.fblogin addGestureRecognizer:fbloginbtn];
           self.fblogin.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *fbloginbtnr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fblogIn:)];
    fbloginbtnr.numberOfTapsRequired = 1;
    [self.fbreg addGestureRecognizer:fbloginbtnr];
    self.fbreg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tutorialBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tutorialBtnAct:)];
    tutorialBtn.numberOfTapsRequired = 1;
           [self.tutorialBtn addGestureRecognizer:tutorialBtn];
           self.tutorialBtn.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *regBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regTabAct:)];
    regBtn.numberOfTapsRequired = 1;
           [self.regimgbtn addGestureRecognizer:regBtn];
           self.regimgbtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *entrBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTabAct:)];
    entrBtn.numberOfTapsRequired = 1;
           [self.entrnceBtn addGestureRecognizer:entrBtn];
           self.entrnceBtn.userInteractionEnabled = YES;
    
   
    
    UITapGestureRecognizer *lognsbmt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginSubmitAct:)];
    lognsbmt.numberOfTapsRequired = 1;
           [self.loginsbmtbtn addGestureRecognizer:lognsbmt];
           self.loginsbmtbtn.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *regsbmt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regSubmitAct:)];
    regsbmt.numberOfTapsRequired = 1;
           [self.regsubmtBtn addGestureRecognizer:regsbmt];
           self.regsubmtBtn.userInteractionEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  // [self perfomExistingAccountSetupFlows];
}

- (void)setupUI {
    
    // Sign In With Apple
    appleIDLoginInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(.0, 40.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) * 0.4) textContainer:nil];
    appleIDLoginInfoTextView.font = [UIFont systemFontOfSize:32.0];
   // [self.view addSubview:appleIDLoginInfoTextView];
    

    if (@available(iOS 13.0, *)) {
    // Sign In With Apple Button
//    ASAuthorizationAppleIDButton *appleIDButton = [ASAuthorizationAppleIDButton new];
//
//    appleIDButton.frame =  CGRectMake(.0, .0, CGRectGetWidth(self.view.frame) - 40.0, 100.0);
//    CGPoint origin = CGPointMake(20.0, CGRectGetMidY(self.view.frame));
//    CGRect frame = appleIDButton.frame;
//    frame.origin = origin;
//    appleIDButton.frame = frame;
      _appleIDButton.cornerRadius = CGRectGetHeight(_appleIDButton.frame) * 0.25;
//    [self.view addSubview:appleIDButton];
    [_appleIDButton addTarget:self action:@selector(handleAuthrization:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"Sign In With Apple \n"];
    appleIDLoginInfoTextView.text = [mStr copy];
}

- (IBAction)tutorialBtnAct:(id)sender {
    self.tutorialView.hidden=FALSE;
    
}
- (IBAction)skipbtnAct:(id)sender {
    self.tutorialView.hidden=TRUE;

}
- (IBAction)regTabAct:(id)sender {
    self.loginView.hidden=TRUE;
    self.regView.hidden=FALSE;
//    self.loginbtn.backgroundColor=[UIColor blackColor];
//    [self.loginbtn setSelected:FALSE];
//    self.regbtn.backgroundColor=[UIColor whiteColor];
//    [self.regbtn setSelected:TRUE];
    
    [self.entrnceBtn setHighlighted:FALSE];
//    self.regbtn.backgroundColor=[UIColor blackColor];
    [self.regimgbtn setHighlighted:TRUE];
}
- (IBAction)loginTabAct:(id)sender {
    self.loginView.hidden=FALSE;
    self.regView.hidden=TRUE;
//    self.loginbtn.backgroundColor=[UIColor whiteColor];
//    [self.loginbtn setSelected:TRUE];
//    self.regbtn.backgroundColor=[UIColor blackColor];
//    [self.regbtn setSelected:FALSE];
    
    [self.entrnceBtn setHighlighted:TRUE];
//    self.regbtn.backgroundColor=[UIColor blackColor];
    [self.regimgbtn setHighlighted:FALSE];
}
- (IBAction)loginSubmitAct:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
     if(([emailTest evaluateWithObject:self.lemailfield.text] == NO) || (self.lemailfield == nil || [self.lemailfield.text isEqualToString:@""]) )
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter correct email" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else if (self.lpaswrdfield == nil || [self.lpaswrdfield.text isEqualToString:@""])
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  paswword" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else{
        [self webserviceCallForLogin:@"1"];
    }
}
- (IBAction)regSubmitAct:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
     if (self.rNamefield == nil || [self.rNamefield.text isEqualToString:@""])
     {
         [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter name" type:RMessageTypeError customTypeName:nil callback:nil];
     }
    else if(([emailTest evaluateWithObject:self.rEmailfield.text] == NO) || (self.rEmailfield == nil || [self.rEmailfield.text isEqualToString:@""]) )
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter correct email" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else if (self.rpaswrdfield == nil || [self.rpaswrdfield.text isEqualToString:@""])
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  paswword" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else if ((self.rcpaswrdfield == nil || [self.lpaswrdfield.text isEqualToString:@""]) && ![self.rcpaswrdfield.text isEqualToString:self.rpaswrdfield.text])
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter same paswword" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else{
        [self webserviceCallForLogin:@"2"];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) webserviceCallForLogin:(NSString *)callchk
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if([callchk isEqual:@"1"])
    {
        [dict setValue:@"signIn" forKey:@"key"];
        [dict setValue:self.lemailfield.text forKey:@"email"];
        [dict setValue:self.lpaswrdfield.text forKey:@"password"];
    }
    if([callchk isEqual:@"2"])
    {
        [dict setValue:@"registration" forKey:@"key"];
        [dict setValue:self.rNamefield.text forKey:@"name"];
        [dict setValue:self.rEmailfield.text forKey:@"email"];
        [dict setValue:self.rpaswrdfield.text forKey:@"password"];
    }

    NSLog(@"%@%@ %@",kBaseURL,kBaseURLSignInAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLSignInAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [activityIndicatorView stopAnimating];
               if([[responseObject valueForKey:@"status"]intValue]>0)
               {
                 
                   if([callchk isEqual:@"2"])
                   {
//                       self.rNamefield.text=@"";
//                       self.rEmailfield.text=@"";
//                       self.rpaswrdfield.text=@"";
//                       self.rcpaswrdfield.text=@"";
//                       [RMessage showNotificationInViewController:self title:@"Success" subtitle:[responseObject valueForKey:@"msg"] type:RMessageTypeSuccess customTypeName:nil callback:nil];
                       
                       NSDictionary *dictu = [responseObject valueForKey:@"data"];
                       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                       [userDefault setBool:true forKey:@"isLoggedIn"];
                  
                       [userDefault setObject:[dictu valueForKey:@"id"] forKey:@"id"];
                       [userDefault setObject:[dictu valueForKey:@"name"] forKey:@"name"];
                       [userDefault setObject:[dictu valueForKey:@"email"] forKey:@"email"];
                       [userDefault setObject:[dictu valueForKey:@"phone"] forKey:@"phone"];
                       [userDefault setObject:[dictu valueForKey:@"apikey"] forKey:@"apikey"];
                       [userDefault setObject:[dictu valueForKey:@"image"] forKey:@"profile_image"];
                       [userDefault synchronize];
                       DashboardViewController *homemain=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
                       [self.navigationController pushViewController:homemain animated:YES];
                   }
                   else
                   {
                       NSDictionary *dictu = [responseObject valueForKey:@"data"];
                       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                       [userDefault setBool:true forKey:@"isLoggedIn"];
                  
                       [userDefault setObject:[dictu valueForKey:@"id"] forKey:@"id"];
                       [userDefault setObject:[dictu valueForKey:@"name"] forKey:@"name"];
                       [userDefault setObject:[dictu valueForKey:@"email"] forKey:@"email"];
                       [userDefault setObject:[dictu valueForKey:@"phone"] forKey:@"phone"];
                       [userDefault setObject:[dictu valueForKey:@"apikey"] forKey:@"apikey"];
                       [userDefault setObject:[dictu valueForKey:@"image"] forKey:@"profile_image"];
                       [userDefault synchronize];
                       DashboardViewController *homemain=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
                       [self.navigationController pushViewController:homemain animated:YES];
                   }
               }
               else
               {
                   [activityIndicatorView stopAnimating];
                   
                   if([callchk isEqual:@"2"])
                   {
                       [RMessage showNotificationInViewController:self title:@"Error" subtitle:[responseObject valueForKey:@"message"] type:RMessageTypeError customTypeName:nil callback:nil];
                   }
                   else
                   {
                       [RMessage showNotificationInViewController:self title:@"Error" subtitle:[responseObject valueForKey:@"message"] type:RMessageTypeError customTypeName:nil callback:nil];
                   }
               }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
          [activityIndicatorView stopAnimating];
                NSLog(@"%@",error);
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  correct details" type:RMessageTypeError customTypeName:nil callback:nil];
    }];
}
-(IBAction)loginRightButton:(id)sender
{
    if (self.pswrdvisiblityBtn.highlighted)
    {
        self.pswrdvisiblityBtn.highlighted = NO;
        self.lpaswrdfield.secureTextEntry = YES;
        if (self.lpaswrdfield.isFirstResponder) {
            [self.lpaswrdfield resignFirstResponder];
            [self.lpaswrdfield becomeFirstResponder];
        }
    }
    else
    {
        self.pswrdvisiblityBtn.highlighted = YES;
        self.lpaswrdfield.secureTextEntry = NO;
        if (self.lpaswrdfield.isFirstResponder) {
            [self.lpaswrdfield resignFirstResponder];
            [self.lpaswrdfield becomeFirstResponder];
        }
    }
}
-(IBAction)pRightButton:(id)sender
{
    if (self.rpswrdvisiblityBtn.highlighted)
    {
        self.rpswrdvisiblityBtn.highlighted = NO;
        self.rpaswrdfield.secureTextEntry = YES;
        if (self.rpaswrdfield.isFirstResponder) {
            [self.lpaswrdfield resignFirstResponder];
            [self.rpaswrdfield becomeFirstResponder];
        }
    }
    else
    {
        self.rpswrdvisiblityBtn.highlighted = YES;
        self.rpaswrdfield.secureTextEntry = NO;
        if (self.rpaswrdfield.isFirstResponder) {
            [self.rpaswrdfield resignFirstResponder];
            [self.rpaswrdfield becomeFirstResponder];
        }
    }
}
-(IBAction)cpRightButton:(id)sender
{
    if (self.rcpswrdvisiblityBtn.highlighted)
    {
        self.rcpswrdvisiblityBtn.highlighted = NO;
        self.rcpaswrdfield.secureTextEntry = YES;
        if (self.rcpaswrdfield.isFirstResponder) {
            [self.rcpaswrdfield resignFirstResponder];
            [self.rcpaswrdfield becomeFirstResponder];
        }
    }
    else
    {
        self.rcpswrdvisiblityBtn.highlighted = YES;
        self.rcpaswrdfield.secureTextEntry = NO;
        if (self.rcpaswrdfield.isFirstResponder) {
            [self.rcpaswrdfield resignFirstResponder];
            [self.rcpaswrdfield becomeFirstResponder];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signIn:(id)sender {
  [GIDSignIn.sharedInstance signInWithConfiguration:signInConfig
                           presentingViewController:self
                                           callback:^(GIDGoogleUser * _Nullable user,
                                                      NSError * _Nullable error) {
      if (error) { return; }
      if (user == nil) { return; }
      semail = user.profile.email;
      sname = user.profile.name;
      NSString *givenName = user.profile.givenName;
      NSString *familyName = user.profile.familyName;

      NSURL *profilePic = [user.profile imageURLWithDimension:320];
      [self webserviceCallForSocialLogin];
    // If sign in succeeded, display the app's main content View.
  }];
}
- (IBAction)fblogIn:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
      [login
       logInWithPermissions: @[@"public_profile",@"email"]
       fromViewController:self
       handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
           if (error) {
               NSLog(@"Process error");
           } else if (result.isCancelled) {
               NSLog(@"Cancelled");
           } else {
               NSLog(@"Logged in");
               [self getFacebookProfileInfo];
           }
       }];
}

-(void)getFacebookProfileInfo {
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields": @"email,name"}];

    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];

    [connection addRequest:requestMe parameters:@{@"fields": @"email,name,first_name"} completion:^(id<FBSDKGraphRequestConnecting>  _Nullable connection, id  _Nullable result, NSError * _Nullable error) {
          
          if(result)
          {
            if ([result objectForKey:@"email"]) {
              NSLog(@"Email: %@",[result objectForKey:@"email"]);
                semail=[result objectForKey:@"email"];
            }
            if ([result objectForKey:@"name"]) {
                sname=[result objectForKey:@"name"];
              NSLog(@"Name : %@",[result objectForKey:@"name"]);
            }
            if ([result objectForKey:@"id"]) {
              NSLog(@"User id : %@",[result objectForKey:@"id"]);
            }
              [self webserviceCallForSocialLogin];
          }
     }];
    [connection start];
}

- (void) webserviceCallForSocialLogin
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"loginSocial" forKey:@"key"];
        [dict setValue:sname forKey:@"name"];
        [dict setValue:semail forKey:@"email"];
//        [dict setValue:self.rpaswrdfield.text forKey:@"password"];
    NSLog(@"%@%@ %@",kBaseURL,kBaseURLSignInAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLSignInAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [activityIndicatorView stopAnimating];
               if([[responseObject valueForKey:@"status"]intValue]>0)
               {
                      NSDictionary *dictu = [responseObject valueForKey:@"data"];
                       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                       [userDefault setBool:true forKey:@"isLoggedIn"];
                       [userDefault setObject:[dictu valueForKey:@"id"] forKey:@"id"];
                       [userDefault setObject:[dictu valueForKey:@"name"] forKey:@"name"];
                       [userDefault setObject:[dictu valueForKey:@"email"] forKey:@"email"];
                       [userDefault setObject:[dictu valueForKey:@"phone"] forKey:@"phone"];
                       [userDefault setObject:[dictu valueForKey:@"apikey"] forKey:@"apikey"];
                       [userDefault setObject:[dictu valueForKey:@"image"] forKey:@"profile_image"];
                       [userDefault synchronize];
                       DashboardViewController *homemain=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
                       [self.navigationController pushViewController:homemain animated:YES];
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
- (IBAction)forgotPassAct:(id)sender {
    ForgotPasswordViewController *homemain=[[ForgotPasswordViewController alloc]initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}


//SIGN IN WITH APPLE

#pragma mark - Actions

- (void)handleAuthrization:(UIButton *)sender {
    if (@available(iOS 13.0, *)) {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        
        // Creates a new Apple ID authorization request.
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        // The contact information to be requested from the user during authentication.
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        // A controller that manages authorization requests created by a provider.
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        
        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        controller.delegate = self;
        
        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        controller.presentationContextProvider = self;
        
        // starts the authorization flows named during controller initialization.
        [controller performRequests];
    }
}
 
#pragma mark - Delegate

 - (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);
    
    NSLog(@"authorization.credential：%@", authorization.credential);
    
    NSMutableString *mStr = [NSMutableString string];
    mStr = [appleIDLoginInfoTextView.text mutableCopy];
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *user = appleIDCredential.user;
        [[NSUserDefaults standardUserDefaults] setValue:user forKey:setCurrentIdentifier];
        [mStr appendString:user?:@""];
        NSString *familyName = appleIDCredential.fullName.familyName;
        [mStr appendString:familyName?:@""];
        NSString *givenName = appleIDCredential.fullName.givenName;
        [mStr appendString:givenName?:@""];
        NSString *email = appleIDCredential.email;
        [mStr appendString:email?:@""];
        NSLog(@"mStr：%@", mStr);
        [mStr appendString:@"\n"];
        appleIDLoginInfoTextView.text = mStr;
        
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        ASPasswordCredential *passwordCredential = authorization.credential;
        NSString *user = passwordCredential.user;
        NSString *password = passwordCredential.password;
        [mStr appendString:user?:@""];
        [mStr appendString:password?:@""];
        [mStr appendString:@"\n"];
        NSLog(@"mStr：%@", mStr);
        appleIDLoginInfoTextView.text = mStr;
    } else {
         mStr = [@"check" mutableCopy];
        appleIDLoginInfoTextView.text = mStr;
    }
}
 

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"error ：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"ASAuthorizationErrorCanceled";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"ASAuthorizationErrorFailed";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"ASAuthorizationErrorInvalidResponse";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"ASAuthorizationErrorNotHandled";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"ASAuthorizationErrorUnknown";
            break;
    }
    
    NSMutableString *mStr = [appleIDLoginInfoTextView.text mutableCopy];
    [mStr appendString:errorMsg];
    [mStr appendString:@"\n"];
    appleIDLoginInfoTextView.text = [mStr copy];
    
    if (errorMsg) {
        return;
    }
    
    if (error.localizedDescription) {
        NSMutableString *mStr = [appleIDLoginInfoTextView.text mutableCopy];
        [mStr appendString:error.localizedDescription];
        [mStr appendString:@"\n"];
        appleIDLoginInfoTextView.text = [mStr copy];
    }
    NSLog(@"controller requests：%@", controller.authorizationRequests);
    /*
     ((ASAuthorizationAppleIDRequest *)(controller.authorizationRequests[0])).requestedScopes
     <__NSArrayI 0x2821e2520>(
     full_name,
     email
     )
     */
}
 
//! Tells the delegate from which window it should present content to the user.
 - (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"window：%s", __FUNCTION__);
    return self.view.window;
}

- (void)dealloc {
    
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}
- (void)observeAppleSignInState {
    if (@available(iOS 13.0, *)) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}

- (void)handleSignInWithAppleStateChanged:(id)noti {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", noti);
}
@end
