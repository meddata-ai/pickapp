//
//  AppDelegate.h
//  PickApp
//
//  Created by Aakash on 17/11/21.
//

#import <UIKit/UIKit.h>
#import "BottomViewController.h"
#import "FindSenderViewController.h"
#import "FindCourierViewController.h"
#import "FavoriteListViewController.h"
#import "SettingsViewController.h"
#import <RMessage/RMessageView.h>
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>
@import AFNetworking;
#import "UrlDeclaration.h"
#import "WelcomeViewController.h"
#import "LoginRegViewController.h"
#import "DashboardViewController.h"
@import GoogleSignIn;
@import FBSDKLoginKit;
@import GooglePlaces;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;


@end

