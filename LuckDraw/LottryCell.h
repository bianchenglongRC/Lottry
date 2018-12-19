//
//  LottryCell.h
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LottryCellType) {
    Male_Normal = 0,
    Female_Normal = 1,
    Female_Notice = 2,
};


@interface LottryCell : UIView


@property (nonatomic, strong) UIImageView *lottryImgView;

@property (nonatomic, strong) UILabel *lottryWorthLbl;

@property (nonatomic, strong) UILabel *lottryCountLbl;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) LottryCellType type;


- (void)setLottryInfo:(NSDictionary *)lottryInfo;

@end




NS_ASSUME_NONNULL_END
