//
//  FindCourierViewController.m
//  PickApp
//
//  Created by Aakash on 22/11/21.
//

#import "FindCourierViewController.h"
#import "FCustomTableViewCell.h"
#import "DeliveryRequestViewController.h"

@interface FindCourierViewController ()
{
    BottomViewController *menuviewc;
    NSMutableArray *senderdata;
    int indxpath;
    int indxpathview;
    long phonenumber;
    NSString *datefldtxt;

    NSString *txtfieldname;
    
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;
}
@end

@implementation FindCourierViewController
{
    UITableView *tableView;
     GMSAutocompleteTableDataSource *tableDataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    menuviewc =  [[BottomViewController alloc] init];
    indxpath=-1;
    indxpathview=-1;
    
    UITapGestureRecognizer *accountBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountBtnAct)];
    accountBtn.numberOfTapsRequired = 1;
    [self.accountBtn addGestureRecognizer:accountBtn];
    self.accountBtn.userInteractionEnabled = YES;
    // Do any additional setup after loading the view from its nib.
    
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    _calendarManager.settings.weekModeEnabled=TRUE;
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
}
- (void)viewWillAppear:(BOOL)animated {
    senderdata= [[NSMutableArray alloc]init];
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
    
    
    self.dateField.delegate=self;
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
    
    
    menuviewc.courierslctdlin.hidden=FALSE;

    
    self.popdetail.layer.cornerRadius=15.0f;
    
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
    
    UITapGestureRecognizer *back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backActn:)];
    back.numberOfTapsRequired = 1;
    [self.backBtn addGestureRecognizer:back];
    self.backBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *addcourier = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addcourierActn)];
    addcourier.numberOfTapsRequired = 1;
    [self.addCourier addGestureRecognizer:addcourier];
    self.addCourier.userInteractionEnabled = YES;
    
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
    
          [self.dateField resignFirstResponder];
    
    

}
- (void)addcourierActn
{
    DeliveryRequestViewController *homemain=[[DeliveryRequestViewController alloc]initWithNibName:@"DeliveryRequestViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)cancelAction: (UIBarButtonItem *) type {
  
    self.datepicker.hidden = YES;
    [self.dateField resignFirstResponder];
   
}
- (void)accountBtnAct {
    SettingsViewController *homemain=[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
   // homemain.requesttype=@"signup";
    [self.navigationController pushViewController:homemain animated:YES];
}
- (void)deliverListAct {
//    FindCourierViewController *homemain=[[FindCourierViewController alloc]initWithNibName:@"FindCourierViewController" bundle:nil];
//   // homemain.requesttype=@"signup";
//    [self.navigationController pushViewController:homemain animated:YES];
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

- (IBAction)searchbtnAct:(id)sender {
  
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
    else{
        indxpath=-1;
        indxpathview=-1;

        [self webserviceCallForSenderList];
    }
}
#pragma Table View Coding
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor clearColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return senderdata.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"FCustomTableViewCell";
    FCustomTableViewCell *cell1 = (FCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if(cell1 == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FCustomTableViewCell" owner:self options:nil];
        cell1 = [nib objectAtIndex:0];
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *listdata=[senderdata objectAtIndex:indexPath.row];
    cell1.locationLabel.text=[NSString stringWithFormat:@"%@ - %@ , %@  ",[listdata valueForKey:@"departure"],[listdata valueForKey:@"destination"],[listdata valueForKey:@"date"] ];
    cell1.feeLabel.text=[NSString stringWithFormat:@"USD $%@",[listdata valueForKey:@"fee"]];
    cell1.commentLabel.text=[NSString stringWithFormat:@"Comment: %@",[listdata valueForKey:@"comment"]];
    cell1.phonenumberLbl.text=[NSString stringWithFormat:@"Phone Number: %@",[listdata valueForKey:@"phone"]];
//    cell1.callView.alpha = 0;
    cell1.callView.hidden = TRUE;
    if(indxpath==indexPath.row)
    {
        [UIView animateWithDuration:0.05
                                  delay:0.05
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
         
                             }
                             completion:^(BOOL finished){
            cell1.callView.hidden = TRUE;
                        CATransition *animation = [CATransition animation];
                         animation.type = kCATransitionFade;
                        animation.subtype = kCATransitionFromRight;
                         animation.duration = 0.1;
                         [cell1.callView.layer addAnimation:animation forKey:nil];
                        cell1.callView.hidden = FALSE;
                             }];
    }
    
    if(indxpathview==indexPath.row)
    {
        [UIView animateWithDuration:0.05
                                  delay:0.05
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
         
                             }
                             completion:^(BOOL finished){
                        CATransition *animation = [CATransition animation];
                         animation.type = kCATransitionFade;
                        animation.subtype = kCATransitionFromRight;
                         animation.duration = 0.1;
                         [cell1.callView.layer addAnimation:animation forKey:nil];
            cell1.callView.hidden = TRUE;
                             }];
    }
    UITapGestureRecognizer *callButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callButtonActn:)];
    callButton.numberOfTapsRequired = 1;
    cell1.callButton.tag=indexPath.row;
    [cell1.callButton addGestureRecognizer:callButton];
    cell1.callButton.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *callviewButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callviewButtonActn:)];
    callviewButton.numberOfTapsRequired = 1;
    cell1.callView.tag=indexPath.row;
    [cell1.callView addGestureRecognizer:callviewButton];
    cell1.callView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pnumberButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pnumberButtonActn:)];
    pnumberButton.numberOfTapsRequired = 1;
    cell1.phonenumberLbl.tag=[[listdata valueForKey:@"phone"] longLongValue];
    [cell1.phonenumberLbl addGestureRecognizer:pnumberButton];
    cell1.phonenumberLbl.userInteractionEnabled = YES;
    
    return cell1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSArray *listdata=[senderdata objectAtIndex:indexPath.row];
    self.departText.text=[NSString stringWithFormat:@"Departure: %@",[listdata valueForKey:@"departure"]];
    self.destText.text=[NSString stringWithFormat:@"Destination: %@",[listdata valueForKey:@"destination"]];
    self.feeText.text=[NSString stringWithFormat:@"Fee: %@ EUR",[listdata valueForKey:@"fee"]];
    self.phoneText.text=[NSString stringWithFormat:@"Phone Number: %@",[listdata valueForKey:@"phone"]];
    self.emailText.text=[NSString stringWithFormat:@"E-mail: %@",[listdata valueForKey:@"email"]];
    self.commentText.text=[NSString stringWithFormat:@"Comment: %@",[listdata valueForKey:@"comment"]];
    [self.commentText sizeToFit];
    self.popdetail.hidden=FALSE;

}
- (void) pnumberButtonActn :(id)sender
{
//   / UIButton *senderButton = (UIButton *)sender;
    phonenumber=[[sender view]tag];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:[NSString stringWithFormat:@"%ld",phonenumber] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];


}
- (void) callviewButtonActn :(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    indxpathview=(int)[[sender view]tag];
    indxpath=-1;
//    [self.senderList reloadData];
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:indxpathview inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];

    [self.senderList reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
}
- (void) callButtonActn :(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    indxpath=(int)[[sender view]tag];
    indxpathview=-1;
//    [self.senderList reloadData];
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:indxpath inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];

    [self.senderList reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];

}

- (void) webserviceCallForSenderList
{
   
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:[UIColor whiteColor] size:80.0f];
    activityIndicatorView.backgroundColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 120.0f, 120.0f);
    activityIndicatorView.center=self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    senderdata= [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
  
    [dict setValue:@"getDeliver" forKey:@"id"];
    [dict setValue:self.departField.text forKey:@"departure"];
    [dict setValue:self.destField.text forKey:@"destination"];
    [dict setValue:datefldtxt forKey:@"date"];

//https://deckwebtech.com/pickapp_demo/getData.php?id=getDeliver&date=2021-02-25&departure=Paris&destination=Moscow
    
    NSLog(@"%@%@ %@",kBaseURL,kBaseURLgetDeliverAPI,dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",kBaseURL,kBaseURLgetDeliverAPI] parameters:dict headers:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [activityIndicatorView stopAnimating];
               if([[responseObject valueForKey:@"status"]intValue]>0)
               {
                   self.senderList.hidden=FALSE;
                   for (NSDictionary *senderldata in [responseObject valueForKey:@"data"])
                   {
                       [self->senderdata addObject:senderldata];
                   }
                   [self.senderList reloadData];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==self.dateField){
        self.datepicker.hidden= NO;
        //[self.dateTravelpickr becomeFirstResponder];

            }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)closePopup:(id)sender {
    self.popdetail.hidden=TRUE;
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



#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    [dayView.textLabel setFont:[UIFont systemFontOfSize:17]];

//     Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor whiteColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    // Selected date
    else
   if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor whiteColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        //dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        //dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = YES;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    NSString* temp;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   // dateob = [dateFormatter stringFromDate:self.dateobPicker.date];
    //self.dateTravelpickr.hidden=false;
  
    temp = [dateFormatter stringFromDate:_dateSelected];
  //  _breedpickField.text=dateob;
datefldtxt=temp;
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
       [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
      temp = [dateFormatter2 stringFromDate:_dateSelected];
  self.dateField.text=[NSString stringWithFormat:@"%@",temp];
    
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

- (IBAction)nextpage:(id)sender {
    [_calendarManager.contentView loadNextPageWithAnimation];
}
- (IBAction)prevpage:(id)sender {
    [_calendarManager.contentView loadPreviousPageWithAnimation];
}
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    [menuItemView setFont:[UIFont systemFontOfSize:19]];
//    menuItemView.textColor=[UIColor whiteColor];
    menuItemView.textColor=[UIColor whiteColor];
    menuItemView.text = [dateFormatter stringFromDate:date];
}
- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.font = [UIFont systemFontOfSize:14];
    }
    
    return view;
}
@end
