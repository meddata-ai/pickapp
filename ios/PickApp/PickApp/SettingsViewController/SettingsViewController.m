//
//  SettingsViewController.m
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import "SettingsViewController.h"
#import "AccountViewController.h"
#import "HelpCenterViewController.h"
#import "NotificationViewController.h"

@interface SettingsViewController ()
{
    BottomViewController *menuviewc;
    UIImage *sendImage;

}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuviewc =  [[BottomViewController alloc] init];

    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *accountView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountViewActn)];
    accountView.numberOfTapsRequired = 1;
    [self.accountView addGestureRecognizer:accountView];
    self.accountView.userInteractionEnabled = YES;
    
}
-(void)viewDidLayoutSubviews
{
   menuviewc.view.frame = self.bottomMenu.bounds;
   [self.bottomMenu addSubview:menuviewc.view];
    
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"profile_image"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.userImage.image = image;
    }];
   
          
    
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
    
    UITapGestureRecognizer *accountView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountViewAct)];
    accountView.numberOfTapsRequired = 1;
           [self.accountView addGestureRecognizer:accountView];
            self.accountView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *helpView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(helpViewAct)];
    helpView.numberOfTapsRequired = 1;
           [self.helpView addGestureRecognizer:helpView];
            self.helpView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *logoutBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutAct)];
    logoutBtn.numberOfTapsRequired = 1;
           [self.logoutBtn addGestureRecognizer:logoutBtn];
            self.logoutBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *profileimageBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileimageAct)];
    profileimageBtn.numberOfTapsRequired = 1;
           [self.photoView addGestureRecognizer:profileimageBtn];
            self.photoView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *notifyview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notfyViewAct)];
    notifyview.numberOfTapsRequired = 1;
           [self.notfyView addGestureRecognizer:notifyview];
            self.notfyView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *logoutys = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutyesAct)];
    logoutys.numberOfTapsRequired = 1;
           [self.logoutys addGestureRecognizer:logoutys];
            self.logoutys.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *logoutno = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutnoAct)];
    logoutno.numberOfTapsRequired = 1;
           [self.logoutno addGestureRecognizer:logoutno];
            self.logoutno.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *logoutcrss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutnoAct)];
    logoutcrss.numberOfTapsRequired = 1;
           [self.logoutcrss addGestureRecognizer:logoutcrss];
            self.logoutcrss.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *inviteview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inviteAct)];
    inviteview.numberOfTapsRequired = 1;
           [self.inviteView addGestureRecognizer:inviteview];
            self.inviteView.userInteractionEnabled = YES;
}
- (void)inviteAct {
    UIApplication *application = [UIApplication sharedApplication];

    NSURL *URL = [NSURL URLWithString:@"https://apps.apple.com/in/app/pickapp-fast-delivery/id1562019603"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
             NSLog(@"Opened url");
        }
    }];
}
- (void)notfyViewAct {
    NotificationViewController *homemain=[[NotificationViewController alloc]initWithNibName:@"NotificationViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)logoutAct {
    self.logoutview.hidden= NO;
    
}
- (void)logoutyesAct {
    NSUserDefaults * removeUD = [NSUserDefaults standardUserDefaults];
        [removeUD removeObjectForKey:@"isLoggedIn"];
        [removeUD removeObjectForKey:@"id"];
        [removeUD removeObjectForKey:@"name"];
        [removeUD removeObjectForKey:@"email"];
        [removeUD removeObjectForKey:@"profile_image"];
         [[NSUserDefaults standardUserDefaults]synchronize ];
    [GIDSignIn.sharedInstance signOut];

        LoginRegViewController *homemain=[[LoginRegViewController alloc]initWithNibName:@"LoginRegViewController" bundle:nil];
        [self.navigationController pushViewController:homemain animated:YES];
}
- (void)logoutnoAct {
    self.logoutview.hidden= YES;
}
- (void)accountViewAct {
    AccountViewController *homemain=[[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:nil];
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)helpViewAct {
    HelpCenterViewController *homemain=[[HelpCenterViewController alloc]initWithNibName:@"HelpCenterViewController" bundle:nil];
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
//    FavoriteListViewController *homemain=[[FavoriteListViewController alloc]initWithNibName:@"FavoriteListViewController" bundle:nil];
//   // homemain.requesttype=@"signup";
//    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)backActn:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)profileimageAct {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
  // sendImage=image;
    //imageView.image=
    self.userImage.image = [self circularScaleAndCropImage:image frame:CGRectMake(0, 0, 320, 320)];


    //self.userImage.layer.cornerRadius  = self.userImage.frame.size.width/2;

  //  self.userImage.clipsToBounds = YES;
   // self.userImage.layer.borderWidth = 3.0f;

   // self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //self.updatebtn.hidden=false;
   // self.updatebtn.userInteractionEnabled=true;
    //[self webserviceCallForUpdateProfilePic];
}

- (UIImage*)circularScaleAndCropImage:(UIImage*)image frame:(CGRect)frame {
    // This function returns a newImage, based on image, that has been:
    // - scaled to fit in (CGRect) rect
    // - and cropped within a circle of radius: rectWidth/2
    
    //Create the bitmap graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Get the width and heights
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat rectWidth = frame.size.width;
    CGFloat rectHeight = frame.size.height;
    
    //Calculate the scale factor
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    //Calculate the centre of the circle
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    
    // Create and CLIP to a CIRCULAR Path
    // (This could be replaced with any closed path if you want a different shaped clip)
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
    //Set the SCALE factor for the graphics context
    //All future draw calls will be scaled by this factor
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    // Draw the IMAGE
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    sendImage=newImage;

    [self webserviceCallForUpdateProfilePic];
    return newImage;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) webserviceCallForUpdateProfilePic
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"apikey"] forKey:@"apiKey"];
    [dict setValue:@"image" forKey:@"key"];
//
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    serializer.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
[manager.requestSerializer setValue:@"application/*" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = [AFJSONResponseSerializer
                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];

    
//    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLUpdateProfileImageApi] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     [manager POST:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLeditUserAPI] parameters:dict headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         [formData appendPartWithFileData:[NSData dataWithData:UIImageJPEGRepresentation(self->sendImage,0.1)] name:@"userImage" fileName:@"userImage.jpg" mimeType:@"image/jpeg"];
         
     }  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [activityIndicatorView stopAnimating];
         NSDictionary *dictu = [responseObject valueForKey:@"data"];

         NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
      
         [userDefault setObject:[dictu valueForKey:@"image"] forKey:@"profile_image"];

         [userDefault synchronize];
         [self.userImage sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"profile_image"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
             self.userImage.image = image;
         }];
        
        [RMessage showNotificationInViewController:self title:@"Success" subtitle:@"Profile picture updated!!" type:RMessageTypeSuccess customTypeName:nil callback:nil];
     }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              NSLog(@"Error: %@", error);
                [activityIndicatorView stopAnimating];
                      NSLog(@"%@",error);
              [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  correct details" type:RMessageTypeError customTypeName:nil callback:nil];
          }];
}
@end
