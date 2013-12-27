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
@property (nonatomic, strong) CBCentralManager *bluetoothCentralManager;
@property (nonatomic, strong) CMMotionActivityManager *motionActivityManager;
@property (nonatomic, strong) NSOperationQueue *motionActivityQueue;
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

- (CBCentralManager *)bluetoothCentralManager
{
    if ( !_bluetoothCentralManager ) {
        _bluetoothCentralManager = [CBCentralManager new];
    }
    return _bluetoothCentralManager;
}

- (CMMotionActivityManager *)motionActivityManager
{
    if ( !_motionActivityManager ) {
        _motionActivityManager = [CMMotionActivityManager new];
    }
    return _motionActivityManager;
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
    
    if ( self.defaultCheckPhotoHandler ) {
        self.defaultCheckPhotoHandler([self photoAccessAuthorization]);
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
    
    if ( self.defaultCheckAddressBookHandler ) {
        self.defaultCheckAddressBookHandler([self addressBookAuthorization]);
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
    
    if ( self.defaultCheckLocationHandler ) {
        self.defaultCheckLocationHandler([self locationAuthorization]);
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
    
    if ( self.defaultCheckEventHandler ) {
        self.defaultCheckEventHandler(type, [self eventAuthorizationForType:type]);
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
    
    if ( self.defaultCheckTwitterHandler ) {
        self.defaultCheckTwitterHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierTwitter]);
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
    
    if ( self.defaultCheckFacebookHandler ) {
        self.defaultCheckFacebookHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierFacebook]);
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
    
    if ( self.defaultCheckSinaWeiboHandler ) {
        self.defaultCheckSinaWeiboHandler([self socialAccountAccessGranted:ACAccountTypeIdentifierSinaWeibo]);
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
    
    if ( self.defaultCheckAdvertisingTrackingHandler ) {
        self.defaultCheckAdvertisingTrackingHandler([self advertisingTrackingGranted]);
    }
}

#pragma mark -
#pragma mark - Microphone

- (void)checkMicrophoneAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    AVAudioSession *audioSession = [[AVAudioSession alloc] init];
    
    if ( [audioSession respondsToSelector:@selector(requestRecordPermission:)] ) {
        /*
         Because this method is synchronous, it is being wrapped in a dispatch block to avoid blocking the main thread.
        */
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [audioSession requestRecordPermission:^(BOOL granted) {
                if ( handler ) {
                    handler(granted);
                    return;
                }
                
                if ( self.defaultCheckMicrophoneHandler ) {
                    self.defaultCheckMicrophoneHandler(granted);
                }
            }];
        });
    } else {
        NSError *error;
        [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
        
        if ( handler ) {
            handler(YES);
            return;
        }
        
        if ( self.defaultCheckMicrophoneHandler ) {
            self.defaultCheckMicrophoneHandler(YES);
        }
    }
}

#pragma mark -
#pragma mark - Bluetooth

- (CBCentralManagerState)bluetoothAuthorization
{
    return [self.bluetoothCentralManager state];
}

- (void)checkBluetoothAccess
{
    [self checkBluetoothAccess:nil];
}

- (void)checkBluetoothAccess:(JRNPrivacyCheckerBluetoothHandler)handler
{
    if ( handler ) {
        handler([self bluetoothAuthorization]);
        return;
    }
    
    if ( self.defaultCheckBluetoothHandler ) {
        self.defaultCheckBluetoothHandler([self bluetoothAuthorization]);
    }
}

#pragma mark -
#pragma mark - Motion

- (void)checkMotionActivityAccess
{
    [self checkMotionActivityAccess:nil];
}

- (void)checkMotionActivityAccess:(JRNPrivacyCheckerGrantedHandler)handler
{
    self.motionActivityQueue = [NSOperationQueue new];
    [self.motionActivityManager startActivityUpdatesToQueue:self.motionActivityQueue withHandler:^(CMMotionActivity *activity) {
        [self.motionActivityManager stopActivityUpdates];
        
        if ( handler ) {
            handler(YES);
            return;
        }
        
        if ( self.defaultCheckMotionActivityHandler ) {
            self.defaultCheckMotionActivityHandler(YES);
        }
    }];
    
    //TODO: How to detect when user denied request.
    //self.defaultCheckMotionActivityHandler(NO);
}

@end
