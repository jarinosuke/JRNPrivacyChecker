//
//  JRNPrivacyChecker.m
//  DemoApp
//
//  Created by jarinosuke on 8/31/13.
//  Copyright (c) 2013 jarinosuke. All rights reserved.
//

#import "JRNPrivacyChecker.h"

static JRNPrivacyChecker *defaultChecker;

@interface JRNPrivacyChecker()
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, assign) ABAddressBookRef addressBook;
@end

@implementation JRNPrivacyChecker

+ (JRNPrivacyChecker *)defaultChecker
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultChecker = [JRNPrivacyChecker new];
    });
    return defaultChecker;
}

#pragma mark -
#pragma mark - Accessor

- (ACAccountStore *)accountStore
{
    if ( !_accountStore ) {
        _accountStore = [ACAccountStore new];
    }
    return _accountStore;
}

#pragma mark -
#pragma mark - Photo

- (ALAuthorizationStatus)checkPhotoAccessAuthorization
{
    return [ALAssetsLibrary authorizationStatus];
}

#pragma mark -
#pragma mark - AddressBook

- (ABAuthorizationStatus)checkAddressBookAuthorization
{
    return ABAddressBookGetAuthorizationStatus();
}

#pragma mark -
#pragma mark - Location

- (CLAuthorizationStatus)checkLocationAuthorization
{
    return [CLLocationManager authorizationStatus];
}

#pragma mark -
#pragma mark - Location

- (EKAuthorizationStatus)checkEventAuthorizationForType:(EKEntityType)type
{
    return [EKEventStore authorizationStatusForEntityType:type];
}

#pragma mark -
#pragma mark - Social

- (BOOL)checkTwitterAccessGranted
{
    return [self checkSocialAccountAccessGranted:ACAccountTypeIdentifierTwitter];
}

- (BOOL)checkFacebookAccessGranted
{
    return [self checkSocialAccountAccessGranted:ACAccountTypeIdentifierFacebook];
}

- (BOOL)checkSinaWeiboAccessGranted
{
    return [self checkSocialAccountAccessGranted:ACAccountTypeIdentifierSinaWeibo];
}

- (BOOL)checkSocialAccountAccessGranted:(NSString *)accountTypeIdentifier
{
    ACAccountType *socialAccount = [self.accountStore accountTypeWithAccountTypeIdentifier:accountTypeIdentifier];
    
    if ( socialAccount ) {
        return [socialAccount accessGranted];
    }
    
    return NO;
}

#pragma mark -
#pragma mark - Ad Tracking

- (BOOL)checkAdvertisingTrackingGranted
{
    return [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
}

@end
