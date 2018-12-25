//
//  GetLotteryView.m
//  LuckDraw
//
//  Created by Blues on 2018/12/25.
//  Copyright © 2018 RC. All rights reserved.
//

#import "AwardLotteryView.h"

@interface AwardLotteryView ()


@property (nonatomic) BOOL isBuildUI;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *lotteryImgView;
@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, strong) UIButton *thanksBtn;
@property (nonatomic, strong) UIButton *continueBtn;

@end


@implementation AwardLotteryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setupUI];
        self.userInteractionEnabled = YES;
        
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

- (void)buildUI
{
    
    self.topImgView = [[UIImageView alloc] init];
    [self.topImgView setImage:[UIImage imageNamed:@"room_zp_girl_get_star_pic"]];
    [self addSubview:self.topImgView];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.height.equalTo(@57);
        make.height.equalTo(@66);
    }];
    
    self.bgImgView = [[UIImageView alloc] init];
    [self.bgImgView setImage:[UIImage imageNamed:@"room_zp_girl_get_bg"]];
    [self addSubview:self.bgImgView];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImgView.mas_centerY).with.offset(-5.f);
        make.leading.equalTo(self).with.offset(15.f);
        make.trailing.equalTo(self).with.offset(-15.f);
        make.height.mas_equalTo(self.bgImgView.mas_width);
    }];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_close"] forState: UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImgView.mas_trailing);
        make.centerY.equalTo(self.bgImgView.mas_top);
        make.height.width.equalTo(@30);
    }];
    
    
    self.lotteryImgView = [[UIImageView alloc] init];
    [self addSubview:self.lotteryImgView];
    [self.lotteryImgView sd_setImageWithURL:[NSURL URLWithString:@"http://39.107.25.202/giftbag/1516609277102884511.png"]];
    [self.lotteryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgImgView).with.insets(UIEdgeInsetsMake(22.2f, 22.2f, 22.2f, 22.2f));
    }];
    
    self.textLbl = [[UILabel alloc] init];
    [self.textLbl setFont:[UIFont fontWithName:FontNameBoldItalic size:25]];
    [self.textLbl setTextColor:[UIColor whiteColor]];
    [self.textLbl setText:@"Congratulate!"];
    [self.textLbl setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.textLbl];
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bgImgView);
        make.height.equalTo(@34);
        make.leading.equalTo(self.bgImgView);
        make.bottom.equalTo(self.bgImgView).with.offset(-18.f);
    }];
    
    self.thanksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.thanksBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_thanks"] forState:UIControlStateNormal];
    [self.thanksBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_thanks_press"] forState:UIControlStateHighlighted];
    [self.thanksBtn setTitle:@"Thanks" forState:UIControlStateNormal];
    [self.thanksBtn.titleLabel setFont:[UIFont fontWithName:FontNameMedium size:16.f]];
    [self.thanksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.thanksBtn addTarget:self action:@selector(thanksBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.thanksBtn];
    [self.thanksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgImgView);
        make.top.equalTo(self.bgImgView.mas_bottom).with.offset(24.f);
        make.height.equalTo(@40.f);
        make.width.equalTo(@144.f);
    }];
    
    self.continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.continueBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_open"] forState:UIControlStateNormal];
    [self.continueBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_open_press"] forState:UIControlStateHighlighted];
    [self.continueBtn setTitle:@"Go on playing" forState:UIControlStateNormal];
    [self.continueBtn.titleLabel setFont:[UIFont fontWithName:FontNameMedium size:16.f]];
    [self.continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.continueBtn addTarget:self action:@selector(goOnPlayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.continueBtn];
    [self.continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bgImgView);
        make.top.equalTo(self.bgImgView.mas_bottom).with.offset(24.f);
        make.height.equalTo(@40.f);
        make.width.equalTo(@144.f);
    }];
    
    [self bringSubviewToFront:self.topImgView];
}

- (void)setLotteryItem:(LotteryModel *)lotteryItem
{
    [self.lotteryImgView sd_setImageWithURL:[NSURL URLWithString:lotteryItem.lotteryImage]];
}

- (void)closeBtnClicked:(id)sender
{
    if (_closeBtnBlock) {
        _closeBtnBlock();
    }
}

- (void)thanksBtnClicked:(id)sender
{
    if (_thanksBtnBlock) {
        _thanksBtnBlock();
    }
}

- (void)goOnPlayBtnClicked:(id)sender
{
    if (_goOnPlayBtnBlock) {
        _goOnPlayBtnBlock();
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
