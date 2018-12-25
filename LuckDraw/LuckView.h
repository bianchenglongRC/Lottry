//
//  LuckView.h
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LuckViewType) {
    LuckView_Male = 0,
    LuckView_Female = 1,
};

@interface LuckView : UIView


@property (nonatomic, copy) void(^closeBtnBlock)(void);

@property (nonatomic, copy) void(^maleCloseBtnBlock)(CGFloat progress);

@property (nonatomic, copy) void(^wantPlayBtnBlock)(void);

@property (nonatomic, assign) LuckViewType luckViewType;

@property (nonatomic, assign) BOOL isGirlAsk;




@end

NS_ASSUME_NONNULL_END
