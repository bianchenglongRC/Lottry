//
//  LotteryCell.h
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LotteryCellType) {
    LotteryCell_Male = 0,
    LotteryCell_Female = 1,
};


@interface LotteryCell : UIView

@property (nonatomic, strong) UIImageView *lotteryImgView;

@property (nonatomic, strong) UILabel *lotteryWorthLbl;

@property (nonatomic, strong) UILabel *lotteryCountLbl;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) LotteryCellType lotteryCellType;


- (void)setLotteryInfo:(NSDictionary *)lotteryInfo;

@end




NS_ASSUME_NONNULL_END
