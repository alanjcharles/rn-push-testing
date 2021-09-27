
/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <Analytics/SEGAnalytics.h>
#import <Analytics/SEGAnalyticsConfiguration.h>

//import Destinations
#import <Segment-Amplitude/SEGAmplitudeIntegrationFactory.h>
#import <Segment-Firebase/SEGFirebaseIntegrationFactory.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  SEGAnalyticsConfiguration* configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:@"YOUR WRITE KEY"];

  //add Destinations
  [configuration use: [SEGAmplitudeIntegrationFactory instance]];
  [configuration use:[SEGFirebaseIntegrationFactory instance]];

  // Use launchOptions to track tapped notifications
    configuration.launchOptions = launchOptions;
    [SEGAnalytics setupWithConfiguration:configuration];

    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
      UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound |
      UIUserNotificationTypeBadge;
      UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
      categories:nil];
      [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
      [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
      UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |
      UIRemoteNotificationTypeBadge;
      [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"pushTest"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[SEGAnalytics sharedAnalytics] registeredForRemoteNotificationsWithDeviceToken:deviceToken];
}

// A notification has been received while the app is running in the foreground
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [[SEGAnalytics sharedAnalytics] receivedRemoteNotification:userInfo];
}

// iOS 8+ only
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  // register to receive notifications
  [application registerForRemoteNotifications];
}
@end
