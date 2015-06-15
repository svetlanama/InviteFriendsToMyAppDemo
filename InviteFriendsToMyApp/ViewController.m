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
                // Do work
                NSLog(@"result %@=",result);
                [self getUser];
            }
            if ([result.grantedPermissions containsObject:@"user_friends"]) {
                // Do work
            }
        }
    }];

    
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

- (IBAction) sendMessagesToFriends:(id)sender {
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://developers.facebook.com"];
    content.contentTitle = @"Please join to my app";
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
    
   
    self.messageButton.shareContent = content;
 

}

- (IBAction) inviteFriends:(id)sender {
    
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://fb.me/426026357570469"];

    //optionally set previewImageURL
    //content.previewImageURL = [NSURL URLWithString:@"https://www.mydomain.com/my_invite_image.jpg"];
    
    // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
    [FBSDKAppInviteDialog showWithContent:content
                                 delegate:self]; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

 
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results {
    NSLog(@"results %@", results);
}

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
