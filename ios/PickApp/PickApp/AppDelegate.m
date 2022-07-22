//
//  AppDelegate.m
//  PickApp
//
//  Created by Aakash on 17/11/21.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [[RMessageView appearance] setTitleFont:[UIFont boldSystemFontOfSize:15]];
    [[RMessageView appearance] setSubtitleFont:[UIFont boldSystemFontOfSize:16]];

    
    [GMSPlacesClient provideAPIKey:@"AIzaSyC6AqyVLby33_9K417eGiEiF4VYr4CAFYM"];

    [[ FBSDKApplicationDelegate sharedInstance ] application : application
                             didFinishLaunchingWithOptions : launchOptions ];
     
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isLoggedIn"] integerValue]==1)
    {
   
            
        DashboardViewController *mvc = [DashboardViewController new];

        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
        nc.navigationBar.translucent = NO;
        nc.navigationBar.hidden=YES;
        self.window.rootViewController = nc;
     
    }
    else
    {
        LoginRegViewController *mvc = [LoginRegViewController new];

        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
        nc.navigationBar.translucent = NO;
        nc.navigationBar.hidden=YES;
        self.window.rootViewController = nc;
    }
  
    return YES;
}
- ( BOOL ) application :( UIApplication *) application
            openURL :( NSURL *) url
            options :( nonnull NSDictionary < UIApplicationOpenURLOptionsKey , id > *) options
 { [[ FBSDKApplicationDelegate sharedInstance ] application : application
  
                                                 openURL : url
                                                 options : options ]; return YES ; }




@end
