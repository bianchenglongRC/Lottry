
#import "ViewController.h"
#import "LuckView.h"

@interface ViewController ()
{
    
}


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    float allWidth = [[UIScreen mainScreen] bounds].size.width;
    float allHeight = [[UIScreen mainScreen] bounds].size.height;
    
    LuckView *luckView_male = [[LuckView alloc] initWithFrame:CGRectMake(0, allHeight-339, allWidth, 339)];
    luckView_male.luckViewType = LuckView_Male;
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
    [self.view addSubview:luckView_female];
    
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
