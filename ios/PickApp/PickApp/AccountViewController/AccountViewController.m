//
//  AccountViewController.m
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import "AccountViewController.h"

@interface AccountViewController ()
{
    BottomViewController *menuviewc;
    int typchk;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    typchk=-1;
    menuviewc =  [[BottomViewController alloc] init];
    self.nameLabel.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    self.numberLabel.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
    self.emailLabelf.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];

    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *nameedit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editnameActn)];
    nameedit.numberOfTapsRequired = 1;
    [self.editNameicon addGestureRecognizer:nameedit];
    self.editNameicon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *editnumber = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editnumberActn)];
    editnumber.numberOfTapsRequired = 1;
    [self.editNoIcon addGestureRecognizer:editnumber];
    self.editNoIcon.userInteractionEnabled = YES;
    
    self.updateView.layer.cornerRadius=10.f;
    self.editableField.layer.cornerRadius=10.f;
    
    
    UITapGestureRecognizer *showhideEmail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showhideEmailActn)];
    showhideEmail.numberOfTapsRequired = 1;
    [self.showhideEmail addGestureRecognizer:showhideEmail];
    self.showhideEmail.userInteractionEnabled = YES;
    
}
-(void)showhideEmailActn
{
    if(self.emailLabelf.secureTextEntry) {
        self.emailLabelf.secureTextEntry=FALSE;
    }
    else
    {
        self.emailLabelf.secureTextEntry=TRUE;
    }
}
-(void)editnameActn
{
    self.poplabel.text=@"Enter your name";
    self.editableField.keyboardType=UIKeyboardTypeDefault;

    self.editableField.text=self.nameLabel.text;
    self.updateView.hidden=FALSE;
    self.popview.hidden=FALSE;

    typchk=1;
}
-(void)editnumberActn
{
    self.poplabel.text=@"Enter your number";
    self.editableField.keyboardType=UIKeyboardTypePhonePad;
    self.editableField.text=self.numberLabel.text;
    self.updateView.hidden=FALSE;
    self.popview.hidden=FALSE;

    typchk=2;
}
- (IBAction)closePopup:(id)sender {
    self.updateView.hidden=TRUE;
    self.popview.hidden=TRUE;

    [self.editableField resignFirstResponder];
}
- (IBAction)submitpopAct:(id)sender {
        if (self.editableField == nil || [self.editableField.text isEqualToString:@""])
        {
            if(typchk==1)
            {
            [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter name" type:RMessageTypeError customTypeName:nil callback:nil];
            }
            if(typchk==2)
            {
                [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter phone number" type:RMessageTypeError customTypeName:nil callback:nil];
            }
        }
    else
    {
        [self webserviceCallUpdateNamePhone:typchk];
    }
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
- (void) webserviceCallUpdateNamePhone:(int )typchk
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(typchk==1)
    {
        [dict setValue:@"editName" forKey:@"key"];
        [dict setValue:self.editableField.text forKey:@"name"];
    }
    if(typchk==2)
    {
        [dict setValue:@"editPhone" forKey:@"key"];
        [dict setValue:self.editableField.text forKey:@"phone"];
    }
    [dict setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"apikey"] forKey:@"apiKey"];
    NSLog(@"%@%@ %@",kBaseURL,kBaseURLeditUserAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLeditUserAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [activityIndicatorView stopAnimating];
               if([[responseObject valueForKey:@"status"]intValue]>0)
               {
                   if(typchk==1)
                   {
                       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                       [userDefault setObject:self.editableField.text forKey:@"name"];
                       [userDefault synchronize];
                       self.nameLabel.text=self.editableField.text;
                       [RMessage showNotificationInViewController:self title:@"Success" subtitle:@"Name updated sucessfully." type:RMessageTypeSuccess customTypeName:nil callback:nil];
                       self.updateView.hidden=TRUE;
                       self.popview.hidden=TRUE;

                       self.editableField.text=@"";
                   }
                   if(typchk==2)
                   {
                       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                       [userDefault setObject:self.editableField.text forKey:@"phone"];
                       [userDefault synchronize];
                       self.numberLabel.text=self.editableField.text;
                       [RMessage showNotificationInViewController:self title:@"Success" subtitle:@"Phone updated sucessfully." type:RMessageTypeSuccess customTypeName:nil callback:nil];
                       self.updateView.hidden=TRUE;
                       self.popview.hidden=TRUE;

                       self.editableField.text=@"";
                   }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
