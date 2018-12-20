//
//  LuckView.m
//  LuckDraw
//
//  Created by Blues on 2018/12/19.
//  Copyright © 2018 RC. All rights reserved.
//

#import "LuckView.h"
#import "Masonry.h"
#import "LotteryCell.h"
#import "InternetRequest/InternetRequest.h"

@interface LuckView()
{
    NSTimer *timer;
    float intervalTime;//变换时间差（用来表示速度）
    float accelerate;//减速度
    float endTimerTotal;//减速共耗时间
    int a;
}

@property (nonatomic, assign) BOOL isBuildUI;
@property (nonatomic, strong) UIImageView *luckBgImgView;
@property (nonatomic, strong) UILabel *priceOneTimeLbl;
@property (nonatomic, strong) UIButton *ruleBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *luckView;
@property (nonatomic, strong) UIImageView *luckWaitView;

@property (nonatomic, strong) UIImageView *ruleView;

@property (nonatomic, strong) LotteryCell *lotteryCell1;
@property (nonatomic, strong) LotteryCell *lotteryCell2;
@property (nonatomic, strong) LotteryCell *lotteryCell3;
@property (nonatomic, strong) LotteryCell *lotteryCell4;
@property (nonatomic, strong) LotteryCell *lotteryCell5;
@property (nonatomic, strong) LotteryCell *lotteryCell6;
@property (nonatomic, strong) LotteryCell *lotteryCell7;
@property (nonatomic, strong) LotteryCell *lotteryCell8;
@property (nonatomic, strong) LotteryCell *currentView;


@property (nonatomic, strong) UIButton *meOpen;
@property (nonatomic, strong) UIButton *sheOpen;

@property (nonatomic, strong) NSArray *cellArray;


@end



@implementation LuckView


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
    
    if (self.luckViewType == LuckView_Male) {
        [self buildMaleLuckViewUI];
    } else {
        [self buildFemaleLuckViewUI];
    }
    
    self.cellArray = [[NSArray alloc] initWithObjects:self.lotteryCell1,self.lotteryCell2,self.lotteryCell3,self.lotteryCell4,self.lotteryCell5,self.lotteryCell6,self.lotteryCell7,self.lotteryCell8,nil];
    int count = (int)self.cellArray.count;
    for (int i=0; i<count; i++) {
        LotteryCell *view = self.cellArray[i];
        view.tag = i;
    }
    endTimerTotal = 5.0;
}


- (void)buildMaleLuckViewUI {
    
    self.luckBgImgView = [[UIImageView alloc] init];
    self.luckBgImgView.userInteractionEnabled = YES;
    [self.luckBgImgView setImage: [UIImage imageNamed:@"room_zp_boy_bg"]];
    [self addSubview:self.luckBgImgView];
    
    [self.luckBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.width.height.equalTo(self);
    }];
    
    self.priceOneTimeLbl = [[UILabel alloc] init];
    self.priceOneTimeLbl.layer.masksToBounds = YES;
    self.priceOneTimeLbl.layer.cornerRadius = 9.f;
    [self.priceOneTimeLbl setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.priceOneTimeLbl setText:@"100/time"];
    [self.priceOneTimeLbl setTextColor:[UIColor whiteColor]];
    [self.priceOneTimeLbl setFont:[UIFont systemFontOfSize:11.f]];
    [self.priceOneTimeLbl setTextAlignment:NSTextAlignmentCenter];
    [self.luckBgImgView addSubview:self.priceOneTimeLbl];
    
    [self.priceOneTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.luckBgImgView).with.offset(16.f);
        make.height.equalTo(@18);
        make.width.equalTo(@73);
    }];
    
    self.closeBtn = [[UIButton alloc] init];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnClickedForMale:) forControlEvents:UIControlEventTouchUpInside];
    [self.luckBgImgView addSubview:self.closeBtn];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.luckBgImgView).with.offset(-16.f);
        make.top.equalTo(self.luckBgImgView).with.offset(16.f);
        make.height.width.equalTo(@18);
    }];
    
    self.ruleBtn = [[UIButton alloc] init];
    [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_FAQ"] forState:UIControlStateNormal];
    //    [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_back"] forState:UIControlStateNormal];
    [self.luckBgImgView addSubview:self.ruleBtn];
    
    [self.ruleBtn addTarget:self action:@selector(ruleBtnClickedForMale:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.closeBtn.mas_leading).with.offset(-16.f);
        make.top.equalTo(self.luckBgImgView).with.offset(16.f);
        make.height.width.equalTo(@18);
    }];
    
    
    
    UIView *topLineView = [[UIView alloc] init];
    [self.luckBgImgView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.luckBgImgView).with.offset(39.f);
        make.leading.width.equalTo(self.luckBgImgView);
        make.height.equalTo(@1);
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    [self.luckBgImgView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.luckBgImgView).with.offset(-48.f);
        make.leading.width.equalTo(self.luckBgImgView);
        make.height.equalTo(@1);
    }];
    
    self.luckView = [[UIView alloc] init];
    [self.luckBgImgView addSubview:self.luckView];
    [self.luckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.luckBgImgView).with.offset(11.f);
        make.trailing.equalTo(self.luckBgImgView).with.offset(-11.f);
        make.top.equalTo(topLineView.mas_bottom).with.offset(3.f);
        make.bottom.equalTo(bottomLineView.mas_top).with.offset(-3.f);
    }];
    
    self.ruleView = [[UIImageView alloc] init];
    [self.ruleView setImage:[UIImage imageNamed:@"room_zp_boy_FAQ_bg"]];
    [self.luckBgImgView addSubview:self.ruleView];
    [self.ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.luckView);
        make.center.equalTo(self.luckView);
    }];
    self.ruleView.hidden = YES;

    
    
    float originX = 11.f;
    float vSpace = 4.f;
    float cellWidth = 114.f;
    float cellHeight = 79.f;
    float orginY = 75.f;
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    
    float hSpace = (allWidth - (cellWidth * 3) - (11*2))/2;
    
    
    self.lotteryCell1 = [[LotteryCell alloc] init];
    self.lotteryCell1.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell1];
    self.lotteryCell2 = [[LotteryCell alloc] init];
    self.lotteryCell2.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell2];
    self.lotteryCell3 = [[LotteryCell alloc] init];
    self.lotteryCell3.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell3];
    self.lotteryCell4 = [[LotteryCell alloc] init];
    self.lotteryCell4.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell4];
    self.lotteryCell5 = [[LotteryCell alloc] init];
    self.lotteryCell5.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell5];
    self.lotteryCell6 = [[LotteryCell alloc] init];
    self.lotteryCell6.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell6];
    self.lotteryCell7 = [[LotteryCell alloc] init];
    self.lotteryCell7.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell7];
    self.lotteryCell8 = [[LotteryCell alloc] init];
    self.lotteryCell8.lotteryCellType = LotteryCell_Male;
    [self.luckView addSubview:self.lotteryCell8];
    
    [self.lotteryCell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.luckView);
        make.width.mas_equalTo(cellWidth);
        make.height.mas_equalTo(cellHeight);
    }];
    
    [self.lotteryCell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1.mas_trailing).with.offset(hSpace);
        make.top.equalTo(self.luckView);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell2.mas_trailing).with.offset(hSpace);
        make.top.equalTo(self.luckView);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell3);
        make.top.equalTo(self.lotteryCell3.mas_bottom).with.offset(vSpace);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell3);
        make.top.equalTo(self.lotteryCell4.mas_bottom).with.offset(vSpace);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell2);
        make.top.equalTo(self.lotteryCell5.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1);
        make.top.equalTo(self.lotteryCell5.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1);
        make.top.equalTo(self.lotteryCell4.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    self.meOpen = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open"] forState:UIControlStateNormal];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open_press"] forState:UIControlStateSelected];
    
    [self.meOpen setTitle:@"OPEN" forState:UIControlStateNormal];
    [self.meOpen.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.meOpen.titleLabel setTextColor:[UIColor whiteColor]];
    [self.meOpen addTarget:self action:@selector(prepareLotteryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.luckView addSubview:self.meOpen];
    
    [self.meOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lotteryCell8).with.offset(5);
        make.leading.equalTo(self.lotteryCell2).with.offset(5);
        make.width.equalTo(self.lotteryCell2).with.offset(-10);
        make.height.equalTo(@32);
    }];
    
    self.sheOpen = [[UIButton alloc] init];
    [self.sheOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_forher"] forState:UIControlStateNormal];
    [self.sheOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_forher_press"] forState:UIControlStateSelected];
    [self.sheOpen.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.sheOpen setTitle:@"Let Her Open" forState:UIControlStateNormal];
    [self.sheOpen.titleLabel setTextColor:[UIColor whiteColor]];
    [self.luckView addSubview:self.sheOpen];
    
    [self.sheOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lotteryCell8).with.offset(-5);
        make.leading.equalTo(self.lotteryCell2).with.offset(5);
        make.width.equalTo(self.lotteryCell2).with.offset(-10);
        make.height.equalTo(@32);
    }];
}



- (void)buildFemaleLuckViewUI
{
    
    self.luckBgImgView = [[UIImageView alloc] init];
    self.luckBgImgView.userInteractionEnabled = YES;
    [self.luckBgImgView setImage: [UIImage imageNamed:@"room_zp_girl_bg"]];
    [self addSubview:self.luckBgImgView];
    
    [self.luckBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).with.offset(15.f);
        make.trailing.equalTo(self).with.offset(-15.f);
        make.height.mas_equalTo(self.luckBgImgView.mas_width);
    }];
    
//    self.priceOneTimeLbl = [[UILabel alloc] init];
//    self.priceOneTimeLbl.layer.masksToBounds = YES;
//    self.priceOneTimeLbl.layer.cornerRadius = 9.f;
//    [self.priceOneTimeLbl setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]];
//    [self.priceOneTimeLbl setText:@"100/time"];
//    [self.luckBgImgView addSubview:self.priceOneTimeLbl];
//
//    [self.priceOneTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.equalTo(self.luckBgImgView).with.offset(16.f);
//        make.height.equalTo(@18);
//        make.width.equalTo(@73);
//    }];
    
    self.closeBtn = [[UIButton alloc] init];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeOrBackClickedForFemale:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self);
        make.height.width.equalTo(@30);
    }];
    
//    UIView *topLineView = [[UIView alloc] init];
//    [self.luckBgImgView addSubview:topLineView];
//    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.luckBgImgView).with.offset(39.f);
//        make.leading.width.equalTo(self.luckBgImgView);
//        make.height.equalTo(@1);
//    }];
//
//    UIView *bottomLineView = [[UIView alloc] init];
//    [self.luckBgImgView addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.luckBgImgView).with.offset(-48.f);
//        make.leading.width.equalTo(self.luckBgImgView);
//        make.height.equalTo(@1);
//    }];
    
    self.luckView = [[UIView alloc] init];
    [self.luckBgImgView addSubview:self.luckView];
    [self.luckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.luckBgImgView).with.insets(UIEdgeInsetsMake(18, 19, 18, 19));
    }];
    
    self.ruleView = [[UIImageView alloc] init];
    [self.ruleView setImage:[UIImage imageNamed:@"room_zp_girl_FAQ_bg"]];
    [self.luckBgImgView addSubview:self.ruleView];
    [self.ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.luckView);
        make.center.equalTo(self.luckView);
    }];
    self.ruleView.hidden = YES;
    
    
    
    float originX = 11.f;
    float vSpace = 2.f;
    float cellWidth = 88.f;
    float cellHeight = 88.f;
    float orginY = 75.f;
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    
    float hSpace = 0.f;
    
    
    self.lotteryCell1 = [[LotteryCell alloc] init];
    self.lotteryCell1.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell1];
    self.lotteryCell2 = [[LotteryCell alloc] init];
    self.lotteryCell2.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell2];
    self.lotteryCell3 = [[LotteryCell alloc] init];
    self.lotteryCell3.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell3];
    self.lotteryCell4 = [[LotteryCell alloc] init];
    self.lotteryCell4.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell4];
    self.lotteryCell5 = [[LotteryCell alloc] init];
    self.lotteryCell5.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell5];
    self.lotteryCell6 = [[LotteryCell alloc] init];
    self.lotteryCell6.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell6];
    self.lotteryCell7 = [[LotteryCell alloc] init];
    self.lotteryCell7.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell7];
    self.lotteryCell8 = [[LotteryCell alloc] init];
    self.lotteryCell8.lotteryCellType = LotteryCell_Female;
    [self.luckView addSubview:self.lotteryCell8];
    
    [self.lotteryCell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.luckView);
        make.width.mas_equalTo(cellWidth);
        make.height.mas_equalTo(cellHeight);
    }];
    
    [self.lotteryCell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1.mas_trailing).with.offset(hSpace);
        make.top.equalTo(self.luckView);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell2.mas_trailing).with.offset(hSpace);
        make.top.equalTo(self.luckView);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell3);
        make.top.equalTo(self.lotteryCell3.mas_bottom).with.offset(vSpace);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell3);
        make.top.equalTo(self.lotteryCell4.mas_bottom).with.offset(vSpace);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell2);
        make.top.equalTo(self.lotteryCell5.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1);
        make.top.equalTo(self.lotteryCell5.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    [self.lotteryCell8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lotteryCell1);
        make.top.equalTo(self.lotteryCell4.mas_top);
        make.width.height.equalTo(self.lotteryCell1);
    }];
    
    
    self.ruleBtn = [[UIButton alloc] init];
    [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_pic_FAQ"] forState:UIControlStateNormal];
    [self.ruleBtn addTarget:self action:@selector(ruleBtnClickedForFemale:) forControlEvents:UIControlEventTouchUpInside];
    [self.luckView addSubview:self.ruleBtn];
    
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lotteryCell8).with.offset(4);
        make.leading.equalTo(self.lotteryCell2).with.offset(4);
        make.width.height.equalTo(self.lotteryCell2).with.offset(-8);
    }];
    
    self.meOpen = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_open"] forState:UIControlStateNormal];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_open_press"] forState:UIControlStateSelected];
        [self.meOpen setTitle:@"OPEN" forState:UIControlStateNormal];
    [self.meOpen.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.meOpen.titleLabel setTextColor:[UIColor whiteColor]];
    [self.meOpen addTarget:self action:@selector(prepareLotteryAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.meOpen];
    [self.meOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(@144);
        make.height.equalTo(@40);
    }];

}



//抽奖按钮按下后的准备工作
- (void)prepareLotteryAction {
    intervalTime = 0.6;//起始的变换时间差（速度）
//    self.currentView.label.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
//    self.currentView.image=[UIImage imageNamed:@"l3"];
//
//    self.currentView = [array objectAtIndex:0];
//    self.currentView.label.textColor = [UIColor whiteColor];
//    self.currentView.image=[UIImage imageNamed:@"l2"];
    
    
    self.currentView.selected = NO;
    self.currentView = (LotteryCell *)[self.cellArray objectAtIndex:0];
    self.currentView.selected = YES;
    self.meOpen.enabled = NO;
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLottery:) userInfo:self.currentView repeats:NO];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [InternetRequest loadDataWithUrlString:@"http://old.idongway.com/sohoweb/q?method=store.get&format=json&cat=1"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                int resultValue = 6;
                [self endLotteryWithResultValue:resultValue];
                
            });
        });
    });
}


- (void)nextAction {
    
    int resultValue = 6;
    [self endLotteryWithResultValue:resultValue];
}

-(void)startLottery:(id)sender{
    int count = self.cellArray.count;
    NSTimer *myTimer = (NSTimer *)sender;
    UIView *preView = (UIView *)myTimer.userInfo;
    int index;
    if (preView==nil) {
        index = 0;
    }else{
        index = [self.cellArray indexOfObject:preView];
    }
    if (index==count-1) {
        self.currentView = [self.cellArray objectAtIndex:0];
    }else{
        self.currentView = [self.cellArray objectAtIndex:index+1];
    }
    
    [self moveCurrentView:self.currentView inArray:self.cellArray];
    
    
    if (intervalTime>0.1) {
        intervalTime = intervalTime - 0.1;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLottery:) userInfo:self.currentView repeats:NO];
}


//红包移动一下
-(void)moveCurrentView:(LotteryCell *)curView inArray:(NSArray *)views{
    
    LotteryCell *preView = (LotteryCell *)[self previewByCurrentView:curView andArray:views];
    preView.selected = NO;
    curView.selected = YES;
}

-(void)endLotteryWithResultValue:(int)resultValue{
    accelerate = [self accelerateSpeedOfTimeMomentWithResultValue:resultValue];
    [self moveToStopWithAccelerate];
}

//减速至停止
-(void)moveToStopWithAccelerate{
    
    static float timeTotal = 0;
    if (timeTotal<endTimerTotal) {
        intervalTime = intervalTime+accelerate;
        timeTotal = timeTotal+intervalTime;
        [timer invalidate];
        self.currentView = (LotteryCell *)[self nextViewByCurrentView:self.currentView andArray:self.cellArray];
        [self moveCurrentView:self.currentView inArray:self.cellArray];
        timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(moveToStopWithAccelerate) userInfo:nil repeats:NO];
    }else{
        [timer invalidate];
        timeTotal = 0;
        [self showAwardView];
        self.meOpen.enabled = YES;
    }
    
}

//得到上一个view
-(UIView *)previewByCurrentView:(LotteryCell *)curView andArray:(NSArray *)views{
    int count = views.count;
    int curIndex = [views indexOfObject:curView];
    int preIndex;
    if (curIndex==0) {
        preIndex = count-1;
    }else{
        preIndex = curIndex-1;
    }
    return [views objectAtIndex:preIndex];
}

//得到下一个view
-(UIView *)nextViewByCurrentView:(LotteryCell *)curView andArray:(NSArray *)views{
    int count = views.count;
    int curIndex = [views indexOfObject:curView];
    int nextIndex;
    if (curIndex==count-1) {
        nextIndex = 0;
    }else{
        nextIndex = curIndex+1;
    }
    return [views objectAtIndex:nextIndex];
}

//计算时间的加速度
-(float)accelerateSpeedOfTimeMomentWithResultValue:(int)resultValue{
    float a;
    int currentIndex = [self.cellArray indexOfObject:self.currentView];
    int count = self.cellArray.count;
    
    int endLength;
    
    if (resultValue>currentIndex+1) {
        endLength = resultValue-currentIndex+count-1;
    }else{
        endLength = 2*count-currentIndex-1+resultValue;
    }
    intervalTime = 0.1;
    a = (2*endTimerTotal/endLength-2*intervalTime)/(endLength-1);
    return a;
    
}

-(void)showAwardView{
    NSLog(@"你中了：%d等奖",self.currentView.tag+1);
}


//static bool selected = NO;
- (void)ruleBtnClickedForMale:(id)sender
{
//    selected = !selected;
//    if (selected) {
//        self.ruleView.hidden = NO;
//        self.luckView.hidden = YES;
//        [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_FAQ_btn_back"] forState:UIControlStateNormal];
//    } else {
//        self.ruleView.hidden = YES;
//        self.luckView.hidden = NO;
//        [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_FAQ"] forState:UIControlStateNormal];
//    }
//
    
    self.ruleView.hidden = NO;
    self.luckView.hidden = YES;
    self.ruleBtn.hidden = YES;
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_FAQ_btn_back"] forState:UIControlStateNormal];

    
    
}

- (void)closeBtnClickedForMale:(id)sender
{
//    if (self.luckView.hidden == YES) {
//        selected = NO;
//        self.luckView.hidden = NO;
//        self.ruleView.hidden = YES;
//        [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_FAQ"] forState:UIControlStateNormal];
//    }
//    if (_closeBtnBlock) {
//        _closeBtnBlock();
//    }
    
    if (self.ruleView.isHidden == YES) {
        if (_closeBtnBlock) {
            _closeBtnBlock();
        }
    } else {
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_close"] forState:UIControlStateNormal];
        self.ruleView.hidden = YES;
        self.luckView.hidden = NO;
        self.ruleBtn.hidden = NO;
    }

}

- (void)ruleBtnClickedForFemale:(id)sender
{
    self.ruleView.hidden = NO;
    self.luckView.hidden = YES;
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_FAQ_btn_back"] forState:UIControlStateNormal];
}

- (void)closeOrBackClickedForFemale:(id)sender
{
    if (self.ruleView.isHidden == YES) {
        if (_closeBtnBlock) {
            _closeBtnBlock();
        }
    } else {
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_girl_btn_close"] forState:UIControlStateNormal];
        self.ruleView.hidden = YES;
        self.luckView.hidden = NO;
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
