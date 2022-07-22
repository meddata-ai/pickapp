//
//  ContactViewController.m
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import "ContactViewController.h"

@interface ContactViewController ()
{
    BottomViewController *menuviewc;
    int tagchk;
    UIImage *frstimg;
    UIImage *scndimg;
    UIImage *thrdimg;

}
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    menuviewc =  [[BottomViewController alloc] init];

    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
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
    
    UITapGestureRecognizer *profileimageBtn1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileimageAct:)];
    profileimageBtn1.numberOfTapsRequired = 1;
    self.frstImage.tag=1;
           [self.frstImage addGestureRecognizer:profileimageBtn1];
            self.frstImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *profileimageBtn2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileimageAct:)];
    profileimageBtn1.numberOfTapsRequired = 1;
    self.secndImage.tag=2;
           [self.secndImage addGestureRecognizer:profileimageBtn2];
            self.secndImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *profileimageBtn3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileimageAct:)];
    profileimageBtn1.numberOfTapsRequired = 1;
    self.thirdImage.tag=3;
           [self.thirdImage addGestureRecognizer:profileimageBtn3];
            self.thirdImage.userInteractionEnabled = YES;

}
- (void)profileimageAct:(id)sender {
    tagchk=(int)[[sender view]tag];
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
    if(tagchk==1)
    {
        self.frstImage.image=image;
        frstimg=image;
    }
    else if(tagchk==2)
    {
        self.secndImage.image=image;
        scndimg=image;

    }
    else if(tagchk==3)
    {
        self.thirdImage.image=image;
        thrdimg=image;

    }
   // self.userImage.image = [self circularScaleAndCropImage:image frame:CGRectMake(0, 0, 320, 320)];


    //self.userImage.layer.cornerRadius  = self.userImage.frame.size.width/2;

  //  self.userImage.clipsToBounds = YES;
   // self.userImage.layer.borderWidth = 3.0f;

   // self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //self.updatebtn.hidden=false;
   // self.updatebtn.userInteractionEnabled=true;
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
- (IBAction)submitAct:(id)sender {
    if (self.msgField == nil || [self.msgField.text isEqualToString:@""])
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter your comment" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else
    {
        [self webserviceCallForSendfeedback];
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
- (void) webserviceCallForSendfeedback
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:67/255.0f green:120/255.0f blue:167/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] forKey:@"email"];
    [dict setValue:@"addPost" forKey:@"id"];
    [dict setValue:self.msgField.text forKey:@"comment"];
    [dict setValue:@"" forKey:@"phone"];

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
     
     [manager POST:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLsendfeedbackAPI] parameters:dict headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(frstimg!=nil)
         {
             [formData appendPartWithFileData:[NSData dataWithData:UIImageJPEGRepresentation(self->frstimg,0.1)] name:@"uploadedFile1" fileName:@"uploadedFile1.jpg" mimeType:@"image/jpeg"];
         }
         if(scndimg!=nil)
         {
             [formData appendPartWithFileData:[NSData dataWithData:UIImageJPEGRepresentation(self->scndimg,0.1)] name:@"uploadedFile2" fileName:@"uploadedFile2.jpg" mimeType:@"image/jpeg"];
         }
         if(thrdimg!=nil)
         {
             [formData appendPartWithFileData:[NSData dataWithData:UIImageJPEGRepresentation(self->thrdimg,0.1)] name:@"uploadedFile3" fileName:@"uploadedFile3.jpg" mimeType:@"image/jpeg"];
         }
         
         
     }  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [activityIndicatorView stopAnimating];
        [RMessage showNotificationInViewController:self title:@"Thanks" subtitle:@"Feedback submitted successfully!!" type:RMessageTypeSuccess customTypeName:nil callback:nil];
     }
          failure:^(NSURLSessionTask *operation, NSError *error) {
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}
@end
