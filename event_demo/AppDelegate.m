//
//  AppDelegate.m
//  event_demo
//
//  Created by yuchen liu on 5/22/15.
//  Copyright (c) 2015 rain. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    NSDateFormatter *_dateFormatter;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
     //2014-12-10T12:13:43.731Z
    
    //local notification for iOS8
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply{
    NSLog(@"handleWatchKitExtensionRequest");
    
    if ([userInfo objectForKey:@"info"]) {
        UINavigationController *rootNavi = (UINavigationController*)self.window.rootViewController;
        
        ViewController *rootVC = (ViewController*)[rootNavi topViewController];
        
        [rootVC.dataSource addObject:[self createObject:userInfo]];
        
        [rootVC.tableView reloadData];
        
        NSIndexPath *bottomIndex = [NSIndexPath indexPathForRow:([rootVC.dataSource count]-1) inSection:0];
        
        
        
        [rootVC.tableView scrollToRowAtIndexPath:bottomIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        NSLog(@"reload data");
    }
}

-(NSArray*)createObject:(NSDictionary *)userInfo{
    
    NSString *des = userInfo[@"info"];
    NSString *date = [_dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *data = @[des, date];
    
    return data;
}

@end
