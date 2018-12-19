//
//  LottryCell.m
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import "LottryCell.h"

@interface LottryCell ()

@property (nonatomic, strong) UIImageView *lottryBgImgView;
@property (nonatomic, strong) UIImageView *lottrySelectView;
@property (nonatomic, strong) UIImageView *lottryCountBgView;

@property (nonatomic, assign) BOOL isBuildUI;

@end


@implementation LottryCell


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
    
    self.lottrySelectView = [[UIImageView alloc] init];
    [self.lottrySelectView setImage:[UIImage imageNamed:@"room_zp_boy_gift_choose"]];
    [self addSubview:self.lottrySelectView];

    self.lottryBgImgView = [[UIImageView alloc] init];
    [self.lottryBgImgView setImage:[UIImage imageNamed:@"room_zp_boy_gift_bg"]];
    [self.lottrySelectView addSubview:self.lottryBgImgView];

    self.lottryImgView = [[UIImageView alloc] init];
    [self.lottrySelectView addSubview:self.lottryImgView];
    
    self.lottryWorthLbl = [[UILabel alloc] init];
    [self.lottryWorthLbl setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:12.f]];
    [self.lottryWorthLbl setTextColor:[UIColor whiteColor]];
    [self.lottrySelectView addSubview:self.lottryWorthLbl];
    
    self.lottryCountBgView = [[UIImageView alloc] init];
    [self.lottryBgImgView addSubview:self.lottryCountBgView];

    
    self.lottryCountLbl = [[UILabel alloc] init];
    [self.lottryCountLbl setFont:[UIFont fontWithName:@"Roboto-Bold" size:11.f]];
    [self.lottryCountLbl setTextColor:[UIColor whiteColor]];
    [self.lottryCountBgView addSubview:self.lottryCountLbl];

    [self.lottrySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.width.height.equalTo(self);
    }];
    
    [self.lottryBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.lottrySelectView).with.offset(5.f);
        make.trailing.bottom.equalTo(self.lottrySelectView).with.offset(-5.f);
    }];
    
    [self.lottryWorthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.leading.trailing.equalTo(self.lottryBgImgView);
        make.bottom.equalTo(self.lottryBgImgView).with.offset(-4.f);
    }];
    
    [self.lottryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lottryBgImgView).offset(29);
        make.top.equalTo(self.lottryBgImgView).offset(9);
        make.trailing.equalTo(self.lottryBgImgView).offset(-29);
        make.bottom.equalTo(self.lottryWorthLbl.mas_top).with.offset(10.f);
    }];
    
    [self.lottryCountBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self.lottryBgImgView);
        make.height.equalTo(@12);
        make.width.equalTo(@20);
    }];
    
    [self.lottryCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.lottryCountBgView);
        make.height.equalTo(@12);
        make.width.equalTo(@11);
    }];
    
}


- (void)setLottryInfo:(NSDictionary *)lottryInfo
{
    
    
    
}

- (void)setSelected:(BOOL)selected
{
    self.lottrySelectView.hidden = !selected;
}


- (void)setType:(LottryCellType)type
{
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
