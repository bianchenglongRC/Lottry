//
//  LotteryCell.m
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import "LotteryCell.h"

@interface LotteryCell ()

@property (nonatomic, strong) UIImageView *lotteryBgImgView;
@property (nonatomic, strong) UIImageView *lotterySelectView;
@property (nonatomic, strong) UIImageView *lotteryCountBgView;

@property (nonatomic, assign) BOOL isBuildUI;

@end


@implementation LotteryCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)layoutSubviews
{
    if (!_isBuildUI) {
        [self buildUI];
        _isBuildUI = YES;
    }
    [super layoutSubviews];
}

- (void)buildUI {
    
    
    
    
    
    self.lotterySelectView = [[UIImageView alloc] init];
    self.lotterySelectView.hidden = YES;
    [self addSubview:self.lotterySelectView];

    self.lotteryBgImgView = [[UIImageView alloc] init];
    [self addSubview:self.lotteryBgImgView];

    self.lotteryImgView = [[UIImageView alloc] init];
    [self.lotteryBgImgView addSubview:self.lotteryImgView];
    
    self.lotteryWorthLbl = [[UILabel alloc] init];
    [self.lotteryWorthLbl setTextAlignment:NSTextAlignmentCenter];
    [self.lotteryBgImgView addSubview:self.lotteryWorthLbl];
    
    self.lotteryCountBgView = [[UIImageView alloc] init];
    [self.lotteryCountBgView setImage:[UIImage imageNamed:@"room_zp_girl_gift_number_bg1"]];
    [self.lotteryBgImgView addSubview:self.lotteryCountBgView];

    self.lotteryCountLbl = [[UILabel alloc] init];
    [self.lotteryCountLbl setFont:[UIFont fontWithName:FontNameNormalBold size:10.f]];
    [self.lotteryCountLbl setTextColor:[UIColor whiteColor]];
    [self.lotteryCountLbl adjustsFontSizeToFitWidth];
    [self.lotteryCountBgView addSubview:self.lotteryCountLbl];

    
    
    if (self.lotteryCellType == LotteryCell_Male) {
        [self buildLotteryCellForMale];
        
    } else {
        [self buildLotteryCellForFemale];
    }
    
    [self.lotterySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.width.height.equalTo(self);
    }];
    
    
}


- (void)buildLotteryCellForMale
{
    [self.lotterySelectView setImage:[UIImage imageNamed:@"room_zp_boy_gift_choose"]];
    [self.lotteryBgImgView setImage:[UIImage imageNamed:@"room_zp_boy_gift_bg"]];
    [self.lotteryWorthLbl setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:12.f]];
    [self.lotteryWorthLbl setTextColor:[UIColor whiteColor]];
    
    [self.lotteryBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.lotterySelectView).with.offset(5.f);
        make.trailing.bottom.equalTo(self.lotterySelectView).with.offset(-5.f);
    }];
    
    [self.lotteryWorthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.leading.trailing.equalTo(self.lotteryBgImgView);
        make.bottom.equalTo(self.lotteryBgImgView).with.offset(-4.f);
    }];
    
    [self.lotteryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@49);
        make.centerX.equalTo(self.lotteryBgImgView);
        make.bottom.equalTo(self.lotteryWorthLbl.mas_top).with.offset(0.f);
    }];
    
    [self.lotteryCountBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self.lotteryBgImgView);
        make.height.equalTo(@12);
        make.width.equalTo(@20);
    }];
    
    [self.lotteryCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.lotteryCountBgView);
        make.height.equalTo(@12);
        make.width.equalTo(@15);
    }];

}

- (void)buildLotteryCellForFemale
{
    [self.lotterySelectView setImage:[UIImage imageNamed:@"room_zp_girl_gift_choose"]];
    [self.lotteryBgImgView setImage:[UIImage imageNamed:@"room_zp_girl_gift_bg"]];
    [self.lotteryWorthLbl setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:12.f]];
    [self.lotteryWorthLbl setTextColor:[UIColor yellowColor]];
    
    [self.lotteryBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.lotterySelectView).with.offset(4.f);
        make.trailing.bottom.equalTo(self.lotterySelectView).with.offset(-4.f);
    }];
    
    [self.lotteryWorthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.leading.trailing.equalTo(self.lotteryBgImgView);
        make.bottom.equalTo(self.lotteryBgImgView).with.offset(-8.f);
    }];
    
    [self.lotteryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryBgImgView).offset(11);
        make.top.equalTo(self.lotteryBgImgView).offset(12);
        make.trailing.equalTo(self.lotteryBgImgView).offset(-11);
        make.bottom.equalTo(self.lotteryWorthLbl.mas_top).with.offset(-4.f);
    }];
    
    [self.lotteryCountBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self.lotteryBgImgView);
        make.height.equalTo(@12);
        make.width.equalTo(@20);
    }];
    
    [self.lotteryCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.lotteryCountBgView);
        make.height.equalTo(@12);
        make.width.equalTo(@15);
    }];
}


- (void)setLotteryInfo:(LotteryModel *)lotteryInfo
{
    [self.lotteryImgView sd_setImageWithURL:[NSURL URLWithString:lotteryInfo.lotteryImage] placeholderImage:nil];
    [self.lotteryWorthLbl setText:[NSString stringWithFormat:@"%@",lotteryInfo.gold]];
    
    if (!lotteryInfo.gainLotteryCount || lotteryInfo.gainLotteryCount.integerValue == 0) {
        self.lotteryCountBgView.hidden = YES;
    }
    
}

- (void)refreshLotteryCountUI:(LotteryModel *)lotteryInfo
{
    if (lotteryInfo.gainLotteryCount && lotteryInfo.gainLotteryCount.integerValue != 0) {
        self.lotteryCountBgView.hidden = NO;
        [self.lotteryCountLbl setText:[NSString stringWithFormat:@"+%@",lotteryInfo.gainLotteryCount]];
    }
}

- (void)setSelected:(BOOL)selected
{
    self.lotterySelectView.hidden = !selected;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
