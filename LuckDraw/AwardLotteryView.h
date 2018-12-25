//
//  GetLotteryView.h
//  LuckDraw
//
//  Created by Blues on 2018/12/25.
//  Copyright © 2018 RC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AwardLotteryView : UIView


@property (nonatomic, copy) void(^closeBtnBlock)(void);
@property (nonatomic, copy) void(^thanksBtnBlock)(void);
@property (nonatomic, copy) void(^goOnPlayBtnBlock)(void);


@property (nonatomic, strong)LotteryModel *lotteryItem;




@end

NS_ASSUME_NONNULL_END
