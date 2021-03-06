
#import "ViewController.h"
#import "LuckView.h"
#import "Masonry.h"
#import "AwardLotteryView.h"

@interface ViewController ()
{
    
}

@property (nonatomic, strong) UIView *waitingView;
@property (nonatomic, strong) ZJCircleProgressView *waitingProgressView;

@property (nonatomic, strong) UIImageView *luckIcon;

@property (nonatomic, strong) NSTimer *discountTimer;
@property (nonatomic) CGFloat discount;
@property (nonatomic) NSInteger maxcount;

@property (nonatomic, strong) AwardLotteryView *awardLotteryView;
@property (nonatomic, strong) LuckView *luckView_male;
@property (nonatomic, strong) LuckView *luckView_female;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    float allHeight = [[UIScreen mainScreen] bounds].size.height;

    self.luckView_male = [[LuckView alloc] initWithFrame:CGRectMake(0, allHeight-339, allWidth, 339)];
    if (SafeArea) {
        self.luckView_male.frame = CGRectMake(0, allHeight-374, allWidth, 374);
    }
    self.luckView_male.luckViewType = LuckView_Male;
    self.luckView_male.isGirlAsk = YES;
    self.luckView_male.hidden = YES;
    __weak ViewController *weakSelf = self;
    [self.luckView_male setMaleCloseBtnBlock:^(CGFloat progress) {
        weakSelf.discount = progress;
        weakSelf.luckView_male.hidden = YES;
        [weakSelf maleWaitingProgressViewShow];
    }];
    [self.view addSubview:self.luckView_male];
    self.luckView_female = [[LuckView alloc] initWithFrame:CGRectMake((allWidth-330)/2, (allHeight-387)/2, 330, 387)];
    [self.luckView_female setCloseBtnBlock:^{
        weakSelf.luckView_female.hidden = YES;
    }];
    [self.luckView_female setWantPlayBtnBlock:^{
        weakSelf.awardLotteryView.hidden = NO;
        weakSelf.luckView_female.hidden = YES;
    }];
    self.luckView_female.luckViewType = LuckView_Female;
    self.luckView_female.hidden = YES;
    [self.view addSubview:self.luckView_female];

    
    self.luckIcon = [[UIImageView alloc] init];
    [self.luckIcon setImage:[UIImage imageNamed:@"zp0"]];
    self.luckIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.luckIcon addGestureRecognizer:tapGest];
    
    [self.view addSubview:self.luckIcon];
    [self.luckIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).with.offset(-8.f);
        make.bottom.equalTo(self.view).with.offset(-90.f);
        make.height.width.equalTo(@40);
    }];

    [self LuckAnimation];
    
    
    self.waitingView = [[UIView alloc] init];
    [self.waitingView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5f]];
    self.waitingView.layer.masksToBounds = YES;
    self.waitingView.layer.cornerRadius = 20.f;
    self.waitingView.hidden = YES;
    self.waitingView.userInteractionEnabled = YES;
    [self.luckIcon addSubview:self.waitingView];
    [self.waitingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.width.height.equalTo(self.luckIcon);
    }];
    
    self.waitingProgressView = [[ZJCircleProgressView alloc] init];
    self.waitingProgressView.trackBackgroundColor = [UIColor whiteColor];
    self.waitingProgressView.trackColor = [UIColor redColor];
    self.waitingProgressView.lineWidth = 4.f;
    //    self.waitingProgressView.progressLabel.hidden = YES;
    [self.waitingProgressView.progressLabel setFont:[UIFont fontWithName:FontNameBoldItalic size:16.f]];
    [self.waitingProgressView.progressLabel setTextColor:[UIColor whiteColor]];
    self.waitingProgressView.clickWise = YES;
    self.waitingProgressView.userInteractionEnabled = YES;
    [self.waitingView addSubview:self.waitingProgressView];
    
    [self.waitingProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.width.height.equalTo(self.waitingView);
    }];
    self.maxcount = 10.f;
    
    [self initAwardLotteryView];
}

- (void)tap:(UIGestureRecognizer *)sender
{
//    luckView_male.hidden = NO;
    
    self.luckView_female.hidden = NO;
}

- (void)initAwardLotteryView
{
    __weak ViewController *weakSelf = self;
    self.awardLotteryView = [[AwardLotteryView alloc] init];
    [self.awardLotteryView setCloseBtnBlock:^{
        weakSelf.awardLotteryView.hidden = YES;
    }];
    
    [self.awardLotteryView setThanksBtnBlock:^{
        
    }];
    
    [self.awardLotteryView setGoOnPlayBtnBlock:^{
        
    }];
    
    [self.view addSubview:self.awardLotteryView];
    self.awardLotteryView.hidden = YES;
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    float allHeight = [[UIScreen mainScreen] bounds].size.height;
    float top = (allHeight - 28 - 300 - 24 - 40)/2;
    [self.awardLotteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@330);
        make.height.equalTo(@392);
        make.top.mas_equalTo(top);
        make.center.equalTo(self.view);
    }];
}

- (void)LuckAnimation
{
    self.luckIcon.animationImages = [self initialImageArray:@"zp"];// 序列帧动画的uiimage数组
    self.luckIcon.animationDuration = 2.0f;// 序列帧全部播放完所用时间
    self.luckIcon.animationRepeatCount = 1;// 序列帧动画重复次数
    [self.luckIcon startAnimating];//开始动画
    [self performSelector:@selector(clearAinimationImageMemory) withObject:nil afterDelay:2.f];//内存的操作
}

// 清除animationImages所占用内存
- (void)clearAinimationImageMemory {
        [self.luckIcon stopAnimating];
        self.luckIcon.animationImages = nil;
}

- (NSArray *)initialImageArray:(NSString *)type {
    NSString * rescourcePath = [[NSBundle mainBundle] pathForResource:@"favor" ofType:@"bundle"];
    NSBundle * bundle =[NSBundle bundleWithPath:rescourcePath];
    if (bundle) {
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 20; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%d.png", type, i];
            //            UIImage *image = [UIImage imageNamed:imageName inBundle:self.imageBundle compatibleWithTraitCollection:nil];
            // 性能优化处，直接以文件路径的形式创建image
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@", [bundle bundlePath], imageName];
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            [imageArray addObject:image];
        }
        return imageArray;
    }
    return nil;
}


- (void)showDiscountTimer
{
    self.discount += 0.05;
    CGFloat progress = self.discount/self.maxcount;
    [self.waitingProgressView setProgress:progress];
    NSInteger remain = self.maxcount - (int)(progress *self.maxcount);
    self.waitingProgressView.progressLabel.text = [NSString stringWithFormat:@"%ldS", remain];
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

- (void)maleWaitingProgressViewShow
{
    
    if (self.discount <= 0) {
        self.waitingView.hidden = YES;
        return;
    }
    self.waitingView.hidden = NO;
    if (self.discountTimer) {
        [self.discountTimer invalidate];
        self.discountTimer = nil;
    }
    self.discountTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(showDiscountTimer) userInfo:nil repeats:YES];
    [self showDiscountTimer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
