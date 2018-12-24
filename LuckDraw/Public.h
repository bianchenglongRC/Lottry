//
//  Public.h
//  LuckDraw
//
//  Created by Blues on 2018/12/24.
//  Copyright © 2018 RC. All rights reserved.
//

#ifndef Public_h
#define Public_h


#define SafeArea ((iPhoneX || iPhoneXR) ? YES : NO)
#define iPhoneXR ([[UIScreen mainScreen] bounds].size.height ==896) //414
#define iPhoneX ([[UIScreen mainScreen] bounds].size.height ==812) //414
#define iPhone6plus ([[UIScreen mainScreen] bounds].size.height ==736) //414
#define iPhone6 ([[UIScreen mainScreen] bounds].size.height ==667)  //375
#define iPhone5 ([[UIScreen mainScreen] bounds].size.height ==568)  //320
#define iPhone4 ([[UIScreen mainScreen] bounds].size.height ==480)  //320

#define IsiPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define FontNameRegular @"AvenirNext-Regular"
#define FontNameMedium @"AvenirNext-Medium"
//#define FontNameBold @"AvenirNext-Bold"
#define FontNameBold @"AvenirNext-DemiBold"
#define FontNameNormalBold @"AvenirNext-Bold"
#define FontNameBoldItalic @"AvenirNext-BoldItalic"



#endif /* Public_h */
