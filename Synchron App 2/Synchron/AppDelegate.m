//
//  AppDelegate.m
//  Synchron
//
//  Created by NCPL Inc on 23/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end
UIStoryboard *storyboard;
UIViewController *controller;

@implementation AppDelegate


//ramsarita211@gmail.com sari@123

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"UB3L6BMcKq6MbjvNCmGTLYQKZXoJM27fpSipBCvy"
                  clientKey:@"GyuC60SxGFaD97HDBhP7pevsOcOfP7b9BipjBXDa"];
    
    CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    if (iOSScreenSize.height==480) {
        [NSThread sleepForTimeInterval:3.0];
        storyboard=[UIStoryboard storyboardWithName:@"iPhone3.5inch" bundle:nil];
    }
    if (iOSScreenSize.height==568) {
        [NSThread sleepForTimeInterval:3.0];
        storyboard=[UIStoryboard storyboardWithName:@"iPhone4inch" bundle:nil];
    }
    if (iOSScreenSize.height==667) {
        [NSThread sleepForTimeInterval:3.0];
        storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    if (iOSScreenSize.height==736) {
        [NSThread sleepForTimeInterval:3.0];
        storyboard=[UIStoryboard storyboardWithName:@"iPhone5.5inch" bundle:nil];
    }
    controller=[storyboard instantiateInitialViewController];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController=controller;
    [self.window makeKeyAndVisible];
    
    // Initialize Parse.
//    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
//        configuration.applicationId = @"UB3L6BMcKq6MbjvNCmGTLYQKZXoJM27fpSipBCvy";
//    
//        //configuration.server = @"http://YOUR_PARSE_SERVER:1337/parse";
//    }]];
   
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    // Override point for customization after application launch.
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

@end
