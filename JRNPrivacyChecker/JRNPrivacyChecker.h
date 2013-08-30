//
//  JRNPrivacyChecker.h
//  DemoApp
//
//  Created by jarinosuke on 8/31/13.
//  Copyright (c) 2013 jarinosuke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>
#import <Accounts/Accounts.h>
#import <AddressBook/AddressBook.h>
#import <AdSupport/AdSupport.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>

typedef void (^JRNPrivacyCheckerPhotoHandler)(ALAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerAddressBookHandler)(ABAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerLocationHandler)(CLAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerEventHandler)(EKEntityType type, EKAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerGrantedHandler)(BOOL isGranted);

@interface JRNPrivacyChecker : NSObject
@property (nonatomic, copy) JRNPrivacyCheckerPhotoHandler checkPhotoHandler;
@property (nonatomic, copy) JRNPrivacyCheckerAddressBookHandler checkAddressBookHandler;
@property (nonatomic, copy) JRNPrivacyCheckerLocationHandler checkLocationHandler;
@property (nonatomic, copy) JRNPrivacyCheckerEventHandler checkEventHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler checkTwitterHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler checkFacebookHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler checkSinaWeiboHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler checkAdvertisingTrackingHandler;

+ (JRNPrivacyChecker *)defaultChecker;

//Photo
- (ALAuthorizationStatus)photoAccessAuthorization;
- (void)checkPhotoAccess;
- (void)checkPhotoAccess:(JRNPrivacyCheckerPhotoHandler)handler;

//AddressBook
- (ABAuthorizationStatus)addressBookAuthorization;
- (void)checkAddressBookAccess;
- (void)checkAddressBookAccess:(JRNPrivacyCheckerAddressBookHandler)handler;

//Location
- (CLAuthorizationStatus)locationAuthorization;
- (void)checkLocationAccess;
- (void)checkLocationAccess:(JRNPrivacyCheckerLocationHandler)handler;
//Event
- (EKAuthorizationStatus)eventAuthorizationForType:(EKEntityType)type;
- (void)checkEventAccess:(EKEntityType)type;
- (void)checkEventAccess:(EKEntityType)type handler:(JRNPrivacyCheckerEventHandler)handler;

//Twitter
- (BOOL)twitterAccessGranted;
- (void)checkTwitterAccess;
- (void)checkTwitterAccess:(JRNPrivacyCheckerGrantedHandler)handler;

//Facebook
- (BOOL)facebookAccessGranted;
- (void)checkFacebookAccess;
- (void)checkFacebookAccess:(JRNPrivacyCheckerGrantedHandler)handler;

//SinaWeibo
- (BOOL)sinaWeiboAccessGranted;
- (void)checkSinWeiboAccess;
- (void)checkSinWeiboAccess:(JRNPrivacyCheckerGrantedHandler)handler;


//Ad Tracking
- (BOOL)advertisingTrackingGranted;
- (void)checkAdvertisingTrackingAccess;
- (void)checkAdvertisingTrackingAccess:(JRNPrivacyCheckerGrantedHandler)handler;

@end
