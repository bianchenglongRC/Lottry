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
#import "LotteryModel.h"

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
@property (nonatomic, strong) UIImageView *waitingView;
@property (nonatomic, strong) ZJCircleProgressView *waitingProgressView;

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

@property (nonatomic, strong) NSTimer *discountTimer;
@property (nonatomic) CGFloat discount;
@property (nonatomic) NSInteger maxcount;

@property (nonatomic, strong) NSMutableArray *maleLotteryArray;
@property (nonatomic, strong) NSMutableArray *femaleLotteryArray;
@property (nonatomic, strong) NSMutableArray *currentLotteryArray;

@property (nonatomic) BOOL isSecondTap;
@property (nonatomic, strong) NSDate *firstDate;
@property (nonatomic, strong) NSDate *secondDate;




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

- (void)initTestData
{

    self.maleLotteryArray = [[NSMutableArray alloc] init];
    self.femaleLotteryArray = [[NSMutableArray alloc] init];
    self.currentLotteryArray = [[NSMutableArray alloc] init];
    NSArray *testLotteryInfoArr = @[@{@"id":@1,@"lotteryImage":@"http://39.107.25.202/giftbag/1524715616646516676.png",@"lotteryName":@"1",@"gold":@20},
                                         @{@"id":@2,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609030594442817.png",@"lotteryName":@"2",@"gold":@50},
                                         @{@"id":@3,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609131896703510.png",@"lotteryName":@"3",@"gold":@20},
                                         @{@"id":@4,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609277102884511.png",@"lotteryName":@"4",@"gold":@500},
                                         @{@"id":@5,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609348811958215.png",@"lotteryName":@"5",@"gold":@5000},
                                         @{@"id":@6,@"lotteryImage":@"http://39.107.25.202/giftbag/1516791362701446796.png",@"lotteryName":@"6",@"gold":@2000},
                                         @{@"id":@7,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609451659490380.png",@"lotteryName":@"7",@"gold":@1500},
                                         @{@"id":@8,@"lotteryImage":@"http://39.107.25.202/giftbag/1516609971957373489.png",@"lotteryName":@"8",@"gold":@200},
                                         ];
    
    for (NSDictionary *testDic in testLotteryInfoArr) {
        NSError *error;
        LotteryModel *lotteryItem = [[LotteryModel alloc]initWithDictionary:testDic error:&error];
        if (!error) {
            [self.maleLotteryArray addObject:lotteryItem];
        }
    }
    
    self.currentLotteryArray =  self.maleLotteryArray;
    
    
    
//    LotteryModel *testCell = []
    
}


- (void)updateMaleLuckViewUI {
    [self.meOpen setTitle:@"OPEN" forState:UIControlStateNormal];
    [self.meOpen.titleLabel setFont:[UIFont fontWithName:FontNameMedium size:12.f]];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open"] forState:UIControlStateNormal];
    [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open_press"] forState:UIControlStateSelected];
    [self.meOpen mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
    }];
    self.sheOpen.hidden =  NO;
    self.isGirlAsk = NO;
}

- (void)buildUI
{
    [self initTestData];
    if (self.luckViewType == LuckView_Male) {
        [self buildMaleLuckViewUI];
    } else {
        [self buildFemaleLuckViewUI];
    }
    
    self.cellArray = [[NSArray alloc] initWithObjects:self.lotteryCell1,self.lotteryCell2,self.lotteryCell3,self.lotteryCell4,self.lotteryCell5,self.lotteryCell6,self.lotteryCell7,self.lotteryCell8,nil];
    int count = (int)self.cellArray.count;
    for (int i=0; i<count; i++) {
        LotteryCell *view = self.cellArray[i];
        LotteryModel *model = self.currentLotteryArray[i];
        [view setLotteryInfo: model];
        view.tag = i;
    }
    endTimerTotal = 5.0;
}

- (void)buildMaleLuckViewUI {
    
    self.luckBgImgView = [[UIImageView alloc] init];
    self.luckBgImgView.userInteractionEnabled = YES;
    [self.luckBgImgView setImage: [UIImage imageNamed:@"room_zp_boy_bg"]];
    
    if (SafeArea) {
        [self.luckBgImgView setImage: [UIImage imageNamed:@"room_zp_boy_xbg"]];
    }
    
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
    CGFloat bottomLine = 49.f;
    if (SafeArea) {
        bottomLine = 83.f;
    }
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.luckBgImgView).with.offset(-bottomLine);
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
        make.width.equalTo(self.luckView).with.offset(-10);
        make.height.equalTo(self.luckView).with.offset(-10);
        make.centerX.equalTo(self.luckView);
        make.top.equalTo(self.luckView).with.offset(15.f);
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
    [self.meOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.meOpen setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [self.meOpen addTarget:self action:@selector(meOpenClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    [self.sheOpen addTarget:self action:@selector(maleWaitingViewShow) forControlEvents:UIControlEventTouchUpInside];
    [self.luckView addSubview:self.sheOpen];
    
    [self.sheOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lotteryCell8).with.offset(-5);
        make.leading.equalTo(self.lotteryCell2).with.offset(5);
        make.width.equalTo(self.lotteryCell2).with.offset(-10);
        make.height.equalTo(@32);
    }];
    
    if (_isGirlAsk) {
        [self.meOpen setTitle:@"Send" forState:UIControlStateNormal];
        [self.meOpen.titleLabel setFont:[UIFont fontWithName:FontNameMedium size:20.f]];
        [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_send"] forState:UIControlStateNormal];
        [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_send_press"] forState:UIControlStateSelected];
        [self.meOpen mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@69);
        }];
//        [self.meOpen mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(self.lotteryCell2).with.offset(-10);
//        }];
        self.sheOpen.hidden = YES;
    } else {
        [self.meOpen setTitle:@"OPEN" forState:UIControlStateNormal];
        [self.meOpen.titleLabel setFont:[UIFont fontWithName:FontNameMedium size:12.f]];
        [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open"] forState:UIControlStateNormal];
        [self.meOpen setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_open_press"] forState:UIControlStateSelected];
        [self.meOpen mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@32);
        }];
        self.sheOpen.hidden =  NO;
    }
    
    
    
    [self.luckBgImgView layoutIfNeeded];
    self.waitingView = [[UIImageView alloc] init];
    [self.waitingView setImage: [UIImage imageNamed:@"room_zp_boy_FAQ_bg"]];
    self.waitingView.hidden = YES;
    [self addSubview:self.waitingView];
    [self.waitingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.luckView).with.offset(-10.f);
        make.height.equalTo(self.luckView).with.offset(-10.f);
        make.centerX.equalTo(self.luckView);
        make.top.equalTo(self.luckView).with.offset(5.f);
    }];
    
    self.waitingProgressView = [[ZJCircleProgressView alloc] init];
    
    self.waitingProgressView.trackBackgroundColor = [UIColor whiteColor];
    self.waitingProgressView.trackColor = [UIColor redColor];
    self.waitingProgressView.lineWidth = 7.f;
//    self.waitingProgressView.progressLabel.hidden = YES;
    self.waitingProgressView.clickWise = YES;
    [self.waitingProgressView.progressLabel setFont:[UIFont fontWithName:FontNameBoldItalic size:20.f]];
    [self.waitingProgressView.progressLabel setTextColor:[UIColor whiteColor]];

    [self.waitingView addSubview:self.waitingProgressView];
    
    [self.waitingProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(56.f);
        make.centerX.equalTo(self.waitingView);
        make.centerY.equalTo(self.waitingView).with.offset(-25.f);

    }];
    self.discount = 0.f;
    self.maxcount = 10.f;
    
//    [self getFontNames];
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


- (void)meOpenClicked:(id)sender
{
    if (self.isSecondTap) {
        self.secondDate = self.firstDate;
        self.firstDate = [NSDate date];
    } else {
        self.secondDate = [NSDate date];
        self.firstDate = [NSDate date];
        self.isSecondTap = YES;
    }
    NSTimeInterval timeInterval = [self.firstDate timeIntervalSinceDate:self.secondDate];
    if (timeInterval >= 1.5f) {
        self.isSecondTap = NO;
    }
    NSLog(@"%f",timeInterval);
}


//抽奖按钮按下后的准备工作
- (void)prepareLotteryAction {
    intervalTime = 0.7;//起始的变换时间差（速度）
//    self.currentView.label.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
//    self.currentView.image=[UIImage imageNamed:@"l3"];
//
//    self.currentView = [array objectAtIndex:0];
//    self.currentView.label.textColor = [UIColor whiteColor];
//    self.currentView.image=[UIImage imageNamed:@"l2"];
    
    
    
    
    self.currentView.selected = NO;
    self.currentView = (LotteryCell *)[self.cellArray objectAtIndex:0];
    self.currentView.selected = YES;
    
    
    if (self.isGirlAsk) {
        self.meOpen.enabled = NO;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLottery:) userInfo:self.currentView repeats:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [InternetRequest loadDataWithUrlString:@"http://old.idongway.com/sohoweb/q?method=store.get&format=json&cat=1"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                int x = 1 + arc4random() % 8;
                int resultValue = x;
                [self endLotteryWithResultValue:resultValue];
                
            });
        });
    });
}


- (void)nextAction {
    
    int x = 1 + arc4random() % 8;
    int resultValue = x;
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
    
    if (self.isGirlAsk) {
        [self updateMaleLuckViewUI];
    }
    
    LotteryModel *currentLotteryItem = [self.currentLotteryArray objectAtIndex:self.currentView.tag];
    
    NSInteger currentGainLotteryCount = currentLotteryItem.gainLotteryCount.integerValue;
    currentGainLotteryCount++;
    
    currentLotteryItem.gainLotteryCount  =  [NSNumber numberWithInteger:currentGainLotteryCount];
    
    [self.currentView refreshLotteryCountUI:currentLotteryItem];
    
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
    self.ruleView.alpha = 0.f;
    [self luckViewShowAnimation];
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
        
        if (_maleCloseBtnBlock) {
            _maleCloseBtnBlock(self.discount);
        }
    } else {
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"room_zp_boy_btn_close"] forState:UIControlStateNormal];
//        self.ruleView.hidden = YES;
        self.ruleBtn.hidden = NO;
        [self luckViewCloseAnimation];
    }
}

- (void)luckViewShowAnimation
{
    [self.ruleView.superview layoutIfNeeded];
    [UIView animateWithDuration:0.5f animations:^{
        [self.ruleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.luckView).with.offset(5);
        }];
        [self.ruleView.superview layoutIfNeeded];
        self.ruleView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

- (void)luckViewCloseAnimation
{
    [self.ruleView.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3f animations:^{
        [self.ruleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.luckView).with.offset(15);
        }];
        [self.ruleView.superview layoutIfNeeded];
        self.ruleView.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.luckView.hidden = NO;
        self.ruleView.hidden = YES;
    }];
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



- (void)showDiscountTimer
{
    self.discount += 0.05;
    CGFloat progress = self.discount/self.maxcount;
    [self.waitingProgressView setProgress:progress];
    NSInteger remain = self.maxcount - (int)(progress *self.maxcount);
    self.waitingProgressView.progressLabel.text = [NSString stringWithFormat:@"%lds", remain];
    if (self.discount > self.maxcount) {
        [self endDiscount];
    }
}

- (void)endDiscount{
    [self.discountTimer invalidate];
    self.discountTimer = nil;
    self.discount = 0.f;
    [self.waitingProgressView setProgress:0.f];
    self.waitingView.hidden = YES;
    
}

- (void)maleWaitingViewShow
{
    self.waitingView.hidden = NO;
    if (self.discountTimer) {
        [self.discountTimer invalidate];
        self.discountTimer = nil;
    }
    self.discountTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(showDiscountTimer) userInfo:nil repeats:YES];
    [self showDiscountTimer];

}

- (void)maleWaitingViewClose
{
    
}


- (void)initforClose
{
    
}

- (void)getFontNames
{
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
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
