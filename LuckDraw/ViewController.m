
#import "ViewController.h"
#import "LuckView.h"
#import "Masonry.h"

@interface ViewController ()
{
    UIImageView *luckIcon;
    LuckView *luckView_male;
}


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    float allHeight = [[UIScreen mainScreen] bounds].size.height;
    
    luckView_male = [[LuckView alloc] initWithFrame:CGRectMake(0, allHeight-339, allWidth, 339)];
    luckView_male.luckViewType = LuckView_Male;
    luckView_male.hidden = YES;
    __weak LuckView *weak_luckView_male = luckView_male;
    [luckView_male setCloseBtnBlock:^{
        weak_luckView_male.hidden = YES;
    }];
    [self.view addSubview:luckView_male];
    LuckView *luckView_female = [[LuckView alloc] initWithFrame:CGRectMake((allWidth-330)/2, (allHeight-387)/2, 330, 387)];
    __weak LuckView *weak_luckView_female = luckView_female;
    [luckView_female setCloseBtnBlock:^{
        weak_luckView_female.hidden = YES;
    }];
    luckView_female.luckViewType = LuckView_Female;
    luckView_female.hidden = YES;
    [self.view addSubview:luckView_female];

    
    luckIcon = [[UIImageView alloc] init];
    [luckIcon setImage:[UIImage imageNamed:@"zp0"]];
    luckIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [luckIcon addGestureRecognizer:tapGest];
    
    [self.view addSubview:luckIcon];
    [luckIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).with.offset(-8.f);
        make.bottom.equalTo(self.view).with.offset(-90.f);
        make.height.width.equalTo(@40);
    }];

    [self LuckAnimation];
}

- (void)tap:(UIGestureRecognizer *)sender
{
    luckView_male.hidden = NO;
}



- (void)LuckAnimation
{
    luckIcon.animationImages = [self initialImageArray:@"zp"];// 序列帧动画的uiimage数组
    luckIcon.animationDuration = 2.0f;// 序列帧全部播放完所用时间
    luckIcon.animationRepeatCount = 1;// 序列帧动画重复次数
    [luckIcon startAnimating];//开始动画
    [self performSelector:@selector(clearAinimationImageMemory) withObject:nil afterDelay:2.f];//内存的操作
}

// 清除animationImages所占用内存
- (void)clearAinimationImageMemory {
        [luckIcon stopAnimating];
        luckIcon.animationImages = nil;
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
