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
#import <AVFoundation/AVFoundation.h>

typedef void (^JRNPrivacyCheckerPhotoHandler)(ALAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerAddressBookHandler)(ABAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerLocationHandler)(CLAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerEventHandler)(EKEntityType type, EKAuthorizationStatus authorizationStatus);
typedef void (^JRNPrivacyCheckerGrantedHandler)(BOOL isGranted);

@interface JRNPrivacyChecker : NSObject
@property (nonatomic, copy) JRNPrivacyCheckerPhotoHandler defaultCheckPhotoHandler;
@property (nonatomic, copy) JRNPrivacyCheckerAddressBookHandler defaultCheckAddressBookHandler;
@property (nonatomic, copy) JRNPrivacyCheckerLocationHandler defaultCheckLocationHandler;
@property (nonatomic, copy) JRNPrivacyCheckerEventHandler defaultCheckEventHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler defaultCheckTwitterHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler defaultCheckFacebookHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler defaultCheckSinaWeiboHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler defaultCheckAdvertisingTrackingHandler;
@property (nonatomic, copy) JRNPrivacyCheckerGrantedHandler defaultCheckMicrophoneHandler;

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

//Microphone
- (void)checkMicrophoneAccess:(JRNPrivacyCheckerGrantedHandler)handler;

@end
