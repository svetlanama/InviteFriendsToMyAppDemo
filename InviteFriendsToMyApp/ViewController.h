//
//  ViewController.h
//  InviteFriendsToMyApp
//
//  Created by Svitlana Moiseyenko on 6/14/15.
//  Copyright (c) 2015 Svitlana Moiseyenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface ViewController : UIViewController <FBSDKAppInviteDialogDelegate>

@property (weak, nonatomic) IBOutlet FBSDKSendButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *inviteFriends;
@property (weak, nonatomic) NSString *userId;


- (IBAction)loginAction:(id)sender;
- (IBAction)sendMessagesToFriends:(id)sender;

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results;
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error;


//- (IBAction)inviteTapped:(id)sender;
@end

