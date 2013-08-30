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
//@property (nonatomic, strong) CLLocationManager *locationManager;
//@property (nonatomic, strong) EKEventStore *eventStore;
//@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
//@property (nonatomic, assign) ABAddressBookRef addressBook;

@property (nonatomic, strong) ACAccountStore *accountStore;
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

- (ALAuthorizationStatus)photoAccessAuthorization
{
    return [ALAssetsLibrary authorizationStatus];
}

- (void)checkPhotoAccess
{
    [self checkPhotoAccess:nil];
}

- (void)checkPhotoAccess:(JRNPrivacyCheckerPhotoHandler)handler
{
    if ( handler ) {
        handler([self photoAccessAuthorization]);
        return;
    }
    
    if ( self.checkPhotoHandler ) {
        self.checkPhotoHandler([self photoAccessAuthorization]);
    }
}

#pragma mark -
#pragma mark - AddressBook

- (ABAuthorizationStatus)addressBookAuthorization
{
    return ABAddressBookGetAuthorizationStatus();
}

- (void)checkAddressBookAccess
{
    [self checkAddressBookAccess:nil];
}

- (void)checkAddressBookAccess:(JRNPrivacyCheckerAddressBookHandler)handler
{
    if ( handler ) {
        handler([self addressBookAuthorization]);
        return;
    }
    
    if ( self.checkAddressBookHandler ) {
        self.checkAddressBookHandler([self addressBookAuthorization]);
    }
}

#pragma mark -
#pragma mark - Location

- (CLAuthorizationStatus)locationAuthorization
{
    return [CLLocationManager authorizationStatus];
}

- (void)checkLocationAccess
{
    [self checkLocationAccess:nil];
}

- (void)checkLocationAccess:(JRNPrivacyCheckerLocationHandler)handler
{
    if ( handler ) {
        handler([self locationAuthorization]);
        return;
    }
    
    if ( self.checkLocationHandler ) {
        self.checkLocationHandler([self locationAuthorization]);
    }
}

#pragma mark -
#pragma mark - Event

- (EKAuthorizationStatus)eventAuthorizationForType:(EKEntityType)type
{
    return [EKEventStore authorizationStatusForEntityType:type];
}

- (void)checkEventAccess:(EKEntityType)type
{
    [self checkEventAccess:type handler:nil];
}

- (void)checkEventAccess:(EKEntityType)type handler:(JRNPrivacyCheckerEventHandler)handler
{
    if ( handler ) {
        handler(type, [self eventAuthorizationForType:type]);
        return;
    }
    
    if ( self.checkEventHandler ) {
        self.checkEventHandler(type, [self eventAuthorizationForType:type]);
    }
}

#pragma mark -
#pragma mark - Social

- (BOOL)twitterAccessGranted
{
    return [self socialAccountAccessGranted:ACAccountTypeIdentifierTwitter];
}

- (void)checkTwitterAccess
{
    [self checkTwitterAccess:nil];
}

- (void)checkTwitterAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    if ( handler ) {
        handler([self socialAccountAccessGranted:ACAccountTypeIdentifierTwitter]);
        return;
    }
    
    if ( self.checkTwitterHandler ) {
        self.checkTwitterHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierTwitter]);
    }
}

- (BOOL)facebookAccessGranted
{
    return [self socialAccountAccessGranted:ACAccountTypeIdentifierFacebook];
}

- (void)checkFacebookAccess
{
    [self checkFacebookAccess:nil];
}

- (void)checkFacebookAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    if ( handler ) {
        handler([self socialAccountAccessGranted:ACAccountTypeIdentifierFacebook]);
        return;
    }
    
    if ( self.checkFacebookHandler ) {
        self.checkFacebookHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierFacebook]);
    }
}

- (BOOL)sinaWeiboAccessGranted
{
    return [self socialAccountAccessGranted:ACAccountTypeIdentifierSinaWeibo];
}

- (void)checkSinWeiboAccess
{
    [self checkSinWeiboAccess:nil];
}

- (void)checkSinWeiboAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    if ( handler ) {
        handler([self socialAccountAccessGranted:ACAccountTypeIdentifierSinaWeibo]);
        return;
    }
    
    if ( self.checkSinaWeiboHandler ) {
        self.checkSinaWeiboHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierSinaWeibo]);
    }
}

- (BOOL)socialAccountAccessGranted:(NSString *)accountTypeIdentifier
{
    ACAccountType *socialAccount = [self.accountStore accountTypeWithAccountTypeIdentifier:accountTypeIdentifier];
    
    if ( socialAccount ) {
        return [socialAccount accessGranted];
    }
    
    return NO;
}

#pragma mark -
#pragma mark - Ad Tracking

- (BOOL)advertisingTrackingGranted
{
    return [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
}

- (void)checkAdvertisingTrackingAccess
{
    [self checkAdvertisingTrackingAccess:nil];
}

- (void)checkAdvertisingTrackingAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    if ( handler ) {
        handler([self advertisingTrackingGranted]);
        return;
    }
    
    if ( self.checkAdvertisingTrackingHandler ) {
        self.checkAdvertisingTrackingHandler([self advertisingTrackingGranted]);
    }
}

@end
