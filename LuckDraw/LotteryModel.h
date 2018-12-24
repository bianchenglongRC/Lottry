//
//  LotteryModel.h
//  LuckDraw
//
//  Created by Blues on 2018/12/24.
//  Copyright © 2018 RC. All rights reserved.
//

#import "BaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LotteryModel : BaseModelObject

@property (nonatomic, copy) NSNumber<Optional> *id;//id
@property (nonatomic, copy) NSString<Optional> *lotteryImage;//图片
@property (nonatomic, copy) NSString<Optional> *lotteryName;//名称
@property (nonatomic, copy) NSNumber<Optional> *gold;//金币
@property (nonatomic, copy) NSNumber<Optional> *gainLotteryCount;//获得次奖品次数

@end

NS_ASSUME_NONNULL_END
