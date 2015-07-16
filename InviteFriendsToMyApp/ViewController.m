//
//  ViewController.m
//  InviteFriendsToMyApp
//
//  Created by Svitlana Moiseyenko on 6/14/15.
//  Copyright (c) 2015 Svitlana Moiseyenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// Facebook
- (IBAction)loginAction:(id)sender{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"email", @"public_profile", @"user_friends",@"read_stream"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self getUser];
            }
            if ([result.grantedPermissions containsObject:@"user_friends"]) {
                // Do work
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) getUser {
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         
         if (!error) {
             NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             self.userId = result[@"id"];
         }
     }];
}

// Share message
- (IBAction) sendMessagesToFriends:(id)sender {
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://developers.facebook.com"];
    content.contentTitle = @"Please join to my app";
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];

    self.messageButton.shareContent = content;
}

// Send invitation to my friends
- (IBAction) inviteFriends:(id)sender {
    
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://fb.me/426026357570469"]; //deeplink
    
    //optionally set previewImageURL
    //content.previewImageURL = [NSURL URLWithString:@"https://www.mydomain.com/my_invite_image.jpg"];
    [FBSDKAppInviteDialog showWithContent:content
                                 delegate:self];
}

// FB delegates
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results {
    NSLog(@"results %@", results);
}

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
