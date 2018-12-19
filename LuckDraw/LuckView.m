//
//  LuckView.m
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import "LuckView.h"
#import "Masonry.h"

@interface LuckView()
{
    
}

@property (nonatomic, assign) BOOL isBuildUI;
@property (nonatomic, strong) UIImageView *luckBgImgView;
@property (nonatomic, strong) UIView *luckView;



@end



@implementation LuckView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupUI];
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
    self.luckBgImgView = [[UIImageView alloc] init];
    [self.luckBgImgView setImage: [UIImage imageNamed:@"room_zp_boy_bg"]];
    [self addSubview:self.luckBgImgView];
    
    [self.luckBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.width.height.equalTo(self);
    }];
    
    
    UIView *topLineView = [[UIView alloc] init];
    [self.luckBgImgView addSubview:topLineView];
    
    
    
    self.luckView = [[UIView alloc] init];
    
    [self.luckBgImgView addSubview:self.luckView];
    [self.luckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.luckBgImgView).with.offset(11.f);
       make.top.equalTo()
    }];
    
    
    
    
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
