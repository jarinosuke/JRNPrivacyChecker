## Requirements

- iOS 6.0 or later.
- ARC

## Features

- make easier and more uniformly for checking each iOS privacy settings.

## Features to be implemented

- request authorization for each privacy settings.
- added new privacy settings in iOS 7.

## Files

- `JRNPrivacyChecker/`  
JRNPrivacyChecker files.

- `DemoApp/`  
files for sample application which lists scheduled local notifications.

## Usage

- 1.Add files in `JRNPrivacyChecker/` to your Xcode project.
- 2.Import JRNPrivacyChecker.h

```objectivec
#import "JRNLocalNotificationCenter.h"
```

- check Photo access.

```objectivec
[[JRNPrivacyChecker defaultChecker] checkPhotoAccess:^(ALAuthorizationStatus authorizationStatus) {
    //handling authorizationStatus
}];
```

## Install
Using [CocoaPods](http://cocoapods.org) is the best way.

```
pod 'JRNPrivacyChecker'
```

### I don't want to use CocoaPods.
OK, please D&D JRNPrivacyChecker folder into your project.

## License

Copyright (c) 2013 Naoki Ishikawa

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
