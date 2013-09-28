//
//  ViewController.m
//  DemoApp
//
//  Created by jarinosuke on 8/31/13.
//  Copyright (c) 2013 jarinosuke. All rights reserved.
//

#import "ViewController.h"
#import "JRNPrivacyChecker.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *eventSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *socialAccountSegmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoButtonTapped:(id)sender
{
    [[JRNPrivacyChecker defaultChecker] checkPhotoAccess:^(ALAuthorizationStatus authorizationStatus) {
        NSString *title = @"Photo";
        NSString *message;
        switch (authorizationStatus) {
            case ALAuthorizationStatusAuthorized:
                message = @"Authorized";
                break;
            case ALAuthorizationStatusDenied:
                message = @"Denied";
                break;
            case ALAuthorizationStatusNotDetermined:
                message = @"Not Determined";
                break;
            case ALAuthorizationStatusRestricted:
                message = @"Restricted";
                break;
            default:
                break;
        }
        
     [self showAlertWithTitle:title message:message];
    }];
}

- (IBAction)addressBookButtonTapped:(id)sender
{
    [[JRNPrivacyChecker defaultChecker] checkAddressBookAccess:^(ABAuthorizationStatus authorizationStatus) {
        NSString *title = @"AddressBook";
        NSString *message;
        switch (authorizationStatus) {
            case kABAuthorizationStatusAuthorized:
                message = @"Authorized";
                break;
            case kABAuthorizationStatusDenied:
                message = @"Denied";
                break;
            case kABAuthorizationStatusNotDetermined:
                message = @"Not Determined";
                break;
            case kABAuthorizationStatusRestricted:
                message = @"Restricted";
                break;
            default:
                break;
        }
        
        [self showAlertWithTitle:title message:message];
    }];
}

- (IBAction)locationButtonTapped:(id)sender
{
    [[JRNPrivacyChecker defaultChecker] checkLocationAccess:^(CLAuthorizationStatus authorizationStatus) {
        NSString *title = @"Location";
        NSString *message;
        switch (authorizationStatus) {
            case kCLAuthorizationStatusAuthorized:
                message = @"Authorized";
                break;
            case kCLAuthorizationStatusDenied:
                message = @"Denied";
                break;
            case kCLAuthorizationStatusNotDetermined:
                message = @"Not Determined";
                break;
            case kCLAuthorizationStatusRestricted:
                message = @"Restricted";
                break;
            default:
                break;
        }
        
        [self showAlertWithTitle:title message:message];
    }];
}

- (IBAction)eventButtonTapped:(id)sender
{
    EKEntityType type;
    if ( self.eventSegmentedControl.selectedSegmentIndex == 0 ) {
        type = EKEntityTypeEvent;
    }
    else {
        type = EKEntityTypeReminder;;
    }
    
    [[JRNPrivacyChecker defaultChecker] checkEventAccess:type
                                                 handler:^(EKEntityType type, EKAuthorizationStatus authorizationStatus) {
                                                     NSString *title;
                                                     NSString *message;
                                                     if ( type == EKEntityTypeEvent ) {
                                                         title = @"Calendar";
                                                     } else {
                                                         title = @"Reminder";
                                                     }
                                                     
                                                     switch (authorizationStatus) {
                                                         case kCLAuthorizationStatusAuthorized:
                                                             message = @"Authorized";
                                                             break;
                                                         case kCLAuthorizationStatusDenied:
                                                             message = @"Denied";
                                                             break;
                                                         case kCLAuthorizationStatusNotDetermined:
                                                             message = @"Not Determined";
                                                             break;
                                                         case kCLAuthorizationStatusRestricted:
                                                             message = @"Restricted";
                                                             break;
                                                         default:
                                                             break;
                                                     }
                                                     
                                                     [self showAlertWithTitle:title message:message];

    }];
}

- (IBAction)socialAccountButtonTapped:(id)sender
{
    NSString *title = [self.socialAccountSegmentedControl titleForSegmentAtIndex:self.socialAccountSegmentedControl.selectedSegmentIndex];
    JRNPrivacyCheckerGrantedHandler handler = ^(BOOL isGranted) {
        NSString *message;
        if ( isGranted ) {
            message = @"Granted";
        } else {
            message = @"Not Granted";
        }
        
        [self showAlertWithTitle:title message:message];
    };
    
    if ( self.socialAccountSegmentedControl.selectedSegmentIndex == 0 ) {
        [[JRNPrivacyChecker defaultChecker] checkTwitterAccess:handler];
    }
    else if ( self.socialAccountSegmentedControl.selectedSegmentIndex == 1 ) {
        [[JRNPrivacyChecker defaultChecker] checkFacebookAccess:handler];
    }
    else {
        [[JRNPrivacyChecker defaultChecker] checkSinWeiboAccess:handler];
    }
}

- (IBAction)adTrackingButtonTapped:(id)sender
{
    [[JRNPrivacyChecker defaultChecker] checkAdvertisingTrackingAccess:^(BOOL isGranted) {
        NSString *title = @"Ad Tracking";
        NSString *message;
        if ( isGranted ) {
            message = @"Granted";
        } else {
            message = @"Not Granted";
        }
        
        [self showAlertWithTitle:title message:message];
    }];
}

- (IBAction)microphoneButtonTapped:(id)sender
{
    [[JRNPrivacyChecker defaultChecker] checkMicrophoneAccess:^(BOOL isGranted) {
        NSString *title = @"Microphone";
        NSString *message;
        if ( isGranted ) {
            message = @"Granted";
        } else {
            message = @"Not Granted";
        }
        
        [self showAlertWithTitle:title message:message];
    }];
}

#pragma mark -
#pragma mark - Alert

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
}

@end
