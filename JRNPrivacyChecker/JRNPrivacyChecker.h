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

@interface JRNPrivacyChecker : NSObject

+ (JRNPrivacyChecker *)defaultChecker;

//Photo
- (ALAuthorizationStatus)checkPhotoAccessAuthorization;

//AddressBook
- (ABAuthorizationStatus)checkAddressBookAuthorization;

//Location
- (CLAuthorizationStatus)checkLocationAuthorization;

//Event
- (EKAuthorizationStatus)checkEventAuthorizationForType:(EKEntityType)type;

//Twitter
- (BOOL)checkTwitterAccessGranted;

//Facebook
- (BOOL)checkFacebookAccessGranted;

//SinaWeibo
- (BOOL)checkSinaWeiboAccessGranted;

//Ad Tracking
- (BOOL)checkAdvertisingTrackingGranted;
@end
