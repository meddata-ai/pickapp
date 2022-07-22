//
//  DeliveryRequestViewController.m
//  PickApp
//
//  Created by Aakash on 19/11/21.
//

#import "DeliveryRequestViewController.h"
#import "AppDelegate.h"

@interface DeliveryRequestViewController ()
{
    BottomViewController *menuviewc;
    NSString *txtfieldname;
    NSArray *cntrycodelist;
    NSString *datefldtxt;
}
@end

@implementation DeliveryRequestViewController
{
     GMSAutocompleteTableDataSource *tableDataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    menuviewc =  [[BottomViewController alloc] init];
    cntrycodelist=[NSArray arrayWithObjects:@"+93", @"+355",@"+213",@"+1684",@"+376",@"+244",@"+1264",@"+672",@"+1268",@"+54",@"+374",@"+297",@"+61",@"+43",@"+994",@"+1242",@"+973",@"+880",@"+1246"@"+375",@"+32",@"+501",@"+229",@"+1441",@"+975",@"+591",@"+387",@"+267"@"+55",@"+1284",@"+673",@"+359",@"+226",@"+95",@"+257",@"+855",@"+237",@"+1",@"+238",@"+1345",@"+236",@"+235",@"+56",@"+86",@"+61",@"+61",@"+57",@"+269",@"+682",@"+506",@"+385",@"+53",@"+357",@"+420",@"+243",@"+45",@"+253",@"+1767",@"+1809",@"+593",@"+20",@" +503",@"+240",@"+291",@"+372",@"+251",@"+500",@"+298",@"+679",@"+358",@"+33",@"+689",@"+241",@"+220",@" +970",@"+995",@"+49",@"+233",@"+350",@"+30",@"+299",@"+1473",@"+1671",@"+502",@"+224",@"+245",@"+592",@"+509",@" +39",@"+504",@"+852",@"+36",@"+354",@"+91",@"+62",@"+98",@"+964",@"+353",@"+44",@"+972",@"+39",@"+225",@"+1876",@"+81",@"+962",@"+7",@"+254",@"+686",@"+381",@"+965",@"+996",@"+856",@"+371",@"+961",@"+266",@"+231",@"+218",@"+423",@"+370",@"+352",@"+853",@"+389",@"+261",@"+265",@"+60",@"+960",@"+223",@"+356",@"+692",@"+222",@"+230",@"+262",@"+52",@"+691",@"+373",@"+377",@"+976",@"+382",@"+1664",@"+212",@"+258",@"+264",@"+674",@"+977",@"+31",@"+599",@"+687",@"+64",@"+505",@"+227",@"+234",@"+683",@"+672",@"+850",@"+1670",@"+47",@"+968",@"+92",@"+680",@"+507",@"+675",@"+595",@"+51",@"+63",@"+870",@"+48",@"+351",@"+1",@"+974",@"+242",@"+40",@"+7",@"+250",@"+590",@"+290",@"+1869",@"+1758",@"+1599",@"+508",@"+1784",@"+685",@"+378",@"+239",@"+966",@"+221",@"+381",@"+248",@"+232",@"+65",@"+421",@"+386",@"+677",@"+252",@"+27",@"+82",@"+34",@"+94",@"+249",@"+597",@"+268",@"+46",@"+41",@"+963",@"+886",@"+992",@"+255",@"+66",@"+670",@"+228",@"+690",@"+676",@" +1868",@"+216",@"+90",@"+993",@" +1649",@"+688",@"+256",@"+380",@"+971",@"+44",@"+1",@"+598",@"+1340",@"+998",@"+678",@"+58",@"+84",@"+681",@"970",@"+967",@"+260",@"+263",nil];

    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height*2);
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *findSenders = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findsenderActn)];
    findSenders.numberOfTapsRequired = 1;
    [self.findSenders addGestureRecognizer:findSenders];
    self.findSenders.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *accountBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountBtnAct)];
    accountBtn.numberOfTapsRequired = 1;
    [self.accountBtn addGestureRecognizer:accountBtn];
    self.accountBtn.userInteractionEnabled = YES;

}
-(void)viewDidLayoutSubviews
{
    
    tableDataSource = [[GMSAutocompleteTableDataSource alloc] init];
     tableDataSource.delegate = self;

//     tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 264, self.view.frame.size.width, self.view.frame.size.height - 44)];
    self.resulttableview.delegate = tableDataSource;
    self.resulttableview.dataSource = tableDataSource;

    self.destintableview.delegate = tableDataSource;
    self.destintableview.dataSource = tableDataSource;
   //  [self.view addSubview:tableView];
    self.resulttableview.hidden=TRUE;
    self.destintableview.hidden=TRUE;
    
    [_departField addTarget:self
                     action:@selector(textFieldDidChange:)
           forControlEvents:UIControlEventEditingChanged];
    _departField.delegate = self;
    [_destField addTarget:self
                     action:@selector(textFieldDidChangedest:)
           forControlEvents:UIControlEventEditingChanged];
    
    
   menuviewc.view.frame = self.bottomMenu.bounds;
   [self.bottomMenu addSubview:menuviewc.view];
    
    
    self.departField.layer.cornerRadius=5.0f;
    self.departField.borderStyle=UITextBorderStyleNone;
    self.departField.clipsToBounds=YES;
    
    self.destField.layer.cornerRadius=5.0f;
    self.destField.borderStyle=UITextBorderStyleNone;
    self.destField.clipsToBounds=YES;
    
    self.dateField.layer.cornerRadius=5.0f;
    self.dateField.borderStyle=UITextBorderStyleNone;
    self.dateField.clipsToBounds=YES;
    
    self.feeField.layer.cornerRadius=5.0f;
    self.feeField.borderStyle=UITextBorderStyleNone;
    self.feeField.clipsToBounds=YES;
    
    self.commentField.layer.cornerRadius=5.0f;
    self.commentField.borderStyle=UITextBorderStyleNone;
    self.commentField.clipsToBounds=YES;
    
    self.phoneField.layer.cornerRadius=5.0f;
    self.phoneField.borderStyle=UITextBorderStyleNone;
    self.phoneField.clipsToBounds=YES;
    
    self.phonepicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 156)];
    self.phonepicker.translatesAutoresizingMaskIntoConstraints = false;
    self.codetextfield.layer.cornerRadius=5.0f;
    self.codetextfield.borderStyle=UITextBorderStyleNone;
    self.codetextfield.clipsToBounds=YES;
    self.codetextfield.delegate = self;
    
    [self.phonepicker setDataSource: self];
    [self.phonepicker setDelegate: self];
    self.phonepicker.hidden = YES;
    self.phonepicker.showsSelectionIndicator = YES;

    self.codetextfield.inputView = self.phonepicker;
    
    self.usdlbl.layer.cornerRadius=5.0f;
    self.usdlbl.clipsToBounds=YES;
    
    self.findSenders.layer.cornerRadius=20.0f;
    self.findSenders.layer.borderWidth=2.0f;

    self.findSenders.layer.borderColor=[UIColor whiteColor].CGColor;
    self.findSenders.clipsToBounds=YES;
    
    UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [toolBar2 setTintColor:[UIColor clearColor]];
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    
    doneButton2.tintColor = [UIColor blueColor];
    
    UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *cancelButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelButton2.tintColor = [UIColor blueColor];
    
    [toolBar2 setItems:[NSArray arrayWithObjects:cancelButton2,space2,doneButton2,nil]];
    self.codetextfield.inputAccessoryView = toolBar2;
    
    self.emailField.layer.cornerRadius=5.0f;
    self.emailField.borderStyle=UITextBorderStyleNone;
    self.emailField.clipsToBounds=YES;
    
    
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
    
    UITapGestureRecognizer *submtbtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitAct:)];
    submtbtn.numberOfTapsRequired = 1;
    [self.submitbtn addGestureRecognizer:submtbtn];
    self.submitbtn.userInteractionEnabled = YES;
    
    self.datepicker = [[UIDatePicker alloc] init];
    self.datepicker.translatesAutoresizingMaskIntoConstraints = false;

 NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
 //NSDate *currentDate = [NSDate date];
 NSCalendar *cal = [NSCalendar currentCalendar];
 NSDate *currentDate = [cal dateByAddingUnit:NSCalendarUnitDay
                                    value:1
                                   toDate:[NSDate date]
                                  options:0];
 
 NSDateComponents *comps = [[NSDateComponents alloc] init];
 [comps setYear:30];
 //NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
 [comps setYear:-30];
 NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];

 [self.datepicker setMinimumDate:currentDate];
    self.datepicker.datePickerMode=UIDatePickerModeDateAndTime;
    if (@available(iOS 13.4, *)) {
        self.datepicker.preferredDatePickerStyle=UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
 //[self.datpicker setMinimumDate:minDate];
    self.datepicker.hidden = NO;
   
 self.dateField.inputView = self.datepicker;
 
 UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
 UIToolbar *toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
  [toolBar setTintColor:[UIColor clearColor]];
 [toolBar1 setTintColor:[UIColor clearColor]];

 UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
 doneButton.tag=1;
 
  doneButton.tintColor = [UIColor blueColor];

  UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  
 UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
  cancelButton.tintColor = [UIColor blueColor];
 cancelButton.tag=1;
 

  [toolBar setItems:[NSArray arrayWithObjects:cancelButton,space,doneButton,nil]];
  self.dateField.inputAccessoryView = toolBar;
    
    
    UIBarButtonItem *cancelButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction1:)];
     cancelButton1.tintColor = [UIColor blueColor];
    cancelButton1.tag=1;
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction1:)];
    doneButton1.tag=1;
    
    doneButton1.tintColor = [UIColor blueColor];

    [toolBar1 setItems:[NSArray arrayWithObjects:cancelButton1,space,doneButton1,nil]];
    
    self.emailField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    self.phoneField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}
- (void)doneAction:(UIBarButtonItem *) type {
    NSLog(@"tag %ld",type.tag);
 
          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          [dateFormatter setDateFormat:@"yyyy-MM-dd"];
         // dateob = [dateFormatter stringFromDate:self.dateobPicker.date];
          //self.dateTravelpickr.hidden=false;
        
          NSString* temp = [dateFormatter stringFromDate:self.datepicker.date];
          self.dateField.text=[NSString stringWithFormat:@"%@",temp];
        //  _breedpickField.text=dateob;
    datefldtxt=self.dateField.text;

          NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
             [dateFormatter2 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            temp = [dateFormatter2 stringFromDate:self.datepicker.date];
        self.dateField.text=[NSString stringWithFormat:@"%@",temp];
         // g_travldatetimedbfrmt= [dateFormatter2 stringFromDate:self.datpicker.date];
          
          [self.dateField resignFirstResponder];
   
}
- (void)cancelAction: (UIBarButtonItem *) type {
    self.datepicker.hidden = YES;
    [self.dateField resignFirstResponder];
}
- (void)doneAction1: (UIBarButtonItem *) type {
    [self.phoneField resignFirstResponder];
}
- (void)cancelAction1: (UIBarButtonItem *) type {
    [self.phoneField resignFirstResponder];
}
- (void)accountBtnAct {
    SettingsViewController *homemain=[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
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
    FavoriteListViewController *homemain=[[FavoriteListViewController alloc]initWithNibName:@"FavoriteListViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)backActn:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)findsenderActn {
    FindSenderViewController *homemain=[[FindSenderViewController alloc]initWithNibName:@"FindSenderViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (IBAction)submitAct:(id)sender {
    if (self.departField == nil || [self.departField.text isEqualToString:@""])
    {
        [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter Departure" type:RMessageTypeError customTypeName:nil callback:nil];
    }
    else if (self.destField == nil || [self.destField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter  Destination" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else if (self.dateField == nil || [self.dateField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please select date" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else if (self.feeField == nil || [self.feeField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter fee" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else if (self.commentField == nil || [self.commentField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter comment" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else if (self.phoneField == nil || [self.phoneField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter phone" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else if (self.emailField == nil || [self.emailField.text isEqualToString:@""])
   {
       [RMessage showNotificationInViewController:self title:@"Error" subtitle:@"Please enter email" type:RMessageTypeError customTypeName:nil callback:nil];
   }
   else{
       [self webserviceCallForAddDelivery];
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
- (void) webserviceCallForAddDelivery
{
   
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

//    senderdata= [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
  
    [dict setValue:@"addDeliver" forKey:@"id"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"apikey"] forKey:@"apiKey"];

    [dict setValue:self.departField.text forKey:@"departure"];
    [dict setValue:self.destField.text forKey:@"destination"];
    [dict setValue:datefldtxt forKey:@"date"];
    [dict setValue:self.feeField.text forKey:@"fee"];
    [dict setValue:self.commentField.text forKey:@"comment"];
    [dict setValue:[NSString stringWithFormat:@"%@%@", self.codetextfield.text,self.phoneField.text] forKey:@"phone"];
    [dict setValue:self.emailField.text forKey:@"email"];
    [dict setValue:@"true" forKey:@"viewEmail"];
    [dict setValue:@"true" forKey:@"viewPhone"];

//https://deckwebtech.com/pickapp_demo/addingData.php?id=addDeliver&apiKey=YavK2cw5ZoBEqTf6W0HCG1OiXx9d7Jnu&departure=&destination=&date=&fee=&comment=&phone=&email=&viewEmail=True&viewPhone=false
    NSLog(@"%@%@ %@",kBaseURL,kBaseURLaddingDataAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLaddingDataAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==self.dateField){
        self.datepicker.hidden= NO;
        //[self.dateTravelpickr becomeFirstResponder];

            }
    if(textField==self.codetextfield)
    {
        self.phonepicker.hidden=NO;
        return YES;
    }
  else
  {
      return YES;
  }
 
}
//map code
- (void)didUpdateAutocompletePredictionsForTableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource {
  // Turn the network activity indicator off.
  UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;

  // Reload table data.
    if([txtfieldname isEqualToString:@"depart"])
    {
        [self.resulttableview reloadData];

    }
    if([txtfieldname isEqualToString:@"destin"])
    {
        [self.destintableview reloadData];

    }
}

- (void)didRequestAutocompletePredictionsForTableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource {
  // Turn the network activity indicator on.
  UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;

  // Reload table data.
    if([txtfieldname isEqualToString:@"depart"])
    {
        [self.resulttableview reloadData];

    }
    if([txtfieldname isEqualToString:@"destin"])
    {
        [self.destintableview reloadData];

    }
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource didAutocompleteWithPlace:(GMSPlace *)place {
  // Do something with the selected place.
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;

  NSLog(@"Place name: %@", place.name);
  NSLog(@"Place address: %@", place.formattedAddress);
  NSLog(@"Place attributions: %@", place.attributions);
    if([txtfieldname isEqualToString:@"depart"])
    {
        [_departField setText:place.name];
       // [self dismissResultsController];
        [_departField resignFirstResponder];
        [_resulttableview setHidden:YES];
    }
    if([txtfieldname isEqualToString:@"destin"])
    {
        [_destField setText:place.name];
       // [self dismissResultsController];
        [_destField resignFirstResponder];
        [_destintableview setHidden:YES];
    }
    
    
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource didFailAutocompleteWithError:(NSError *)error {
  // Handle the error
  NSLog(@"Error %@", error.description);
}

- (BOOL)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource didSelectPrediction:(GMSAutocompletePrediction *)prediction {
    
  return YES;
}
- (void)textFieldDidChange:(UITextField *)textField {
    txtfieldname=@"depart";
    self.resulttableview.hidden=FALSE;
    self.destintableview.hidden=TRUE;
  [tableDataSource sourceTextHasChanged:textField.text];
}
- (void)textFieldDidChangedest:(UITextField *)textField {
    txtfieldname=@"destin";
    self.destintableview.hidden=FALSE;
    self.resulttableview.hidden=TRUE;

  [tableDataSource sourceTextHasChanged:textField.text];
}
- (IBAction)filter:(id)sender
{
    self.commentField.text = [self.commentField.text iod_filteredString];
    
}


//implement the required methods for the delegate and data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
        return cntrycodelist.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    self.phonepicker.hidden= NO;

        return cntrycodelist[row];
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     
    return;
}
- (void)doneAction {
    if(![[self pickerView:self.phonepicker titleForRow:[self.phonepicker selectedRowInComponent:0] forComponent:1] isEqual:@"Select Role"])
    {
        self.codetextfield.text=[self pickerView:self.phonepicker titleForRow:[self.phonepicker selectedRowInComponent:0] forComponent:1];
    }
   else
   {
       self.codetextfield.text=@"";
   }
        [_codetextfield resignFirstResponder];

}
- (void)cancelAction {
 self.phonepicker.hidden = YES;
   
     [_codetextfield resignFirstResponder];
   
}
@end
