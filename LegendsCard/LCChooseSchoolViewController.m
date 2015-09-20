//
//  LCChooseSchoolViewController.m
//  LegendsCard
//
//  Created by Josh Sklar on 9/4/13.
//  Copyright (c) 2013 LegendsCard. All rights reserved.
//

#import "LCChooseSchoolViewController.h"
#import "User.h"
#import "LCCardIDViewController.h"
#import "LCEmailViewController.h"

static const NSInteger kMichiganButtonTag = 0;
static const NSInteger kIUButtonTag = 1;
static const NSInteger kFloridaButtonTag = 2;

@implementation UIView (Positioning)

- (CGFloat)getPositionOfBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

@end

@interface LCChooseSchoolViewController ()

@property (strong, nonatomic) LCCardIDViewController *cardIDViewController;
@property (strong, nonatomic) LCEmailViewController *emailViewController;

@end

@implementation LCChooseSchoolViewController

- (id)init
{
    if (self = [super init]) {
        self.block = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    self.cardIDViewController = [[LCCardIDViewController alloc] init];
    self.cardIDViewController.delegate = self;
    
    self.emailViewController = [[LCEmailViewController alloc] init];
    self.emailViewController.delegate = self;

    [self setupView];
}

- (void)setupView
{
    UILabel *cs = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    [cs setTextAlignment:NSTextAlignmentCenter];
    [cs setBackgroundColor:[UIColor clearColor]];
    [cs setTextColor:[UIColor colorWithRed:91./255. green:91./255. blue:91./255. alpha:1.]];
    [cs setFont:[UIFont fontWithName:@"Cubano-Regular" size:35]];
    [cs setText:@"Choose School"];
    [self.view addSubview:cs];
    
    static CGFloat btnSize = 100.;
    CGFloat buffer = 80.;
    
    if ([UIScreen mainScreen].bounds.size.height == 480.) // iPhone 4
        buffer = 60.;
    
    CGFloat originX = self.view.frame.size.width/2. - btnSize/2.;
    
    UIButton *mich = [[UIButton alloc]initWithFrame:CGRectMake(originX, [cs getPositionOfBottom] + buffer, btnSize, btnSize)];
    mich.tag = kMichiganButtonTag;
    [mich setBackgroundImage:[UIImage imageNamed:@"block-m"]
                    forState:UIControlStateNormal];
    
    UIButton *iu = [[UIButton alloc]initWithFrame:CGRectMake(originX, [mich getPositionOfBottom] + buffer, btnSize, btnSize)];
    iu.tag = kIUButtonTag;
    [iu setBackgroundImage:[UIImage imageNamed:@"iu"]
                  forState:UIControlStateNormal];

    UIButton *florida = [[UIButton alloc]initWithFrame:CGRectMake(originX, [iu getPositionOfBottom] + buffer, btnSize, btnSize / 3.f * 2.f)];
    florida.tag = kFloridaButtonTag;
    [florida setBackgroundImage:[UIImage imageNamed:@"florida"]
                  forState:UIControlStateNormal];

    for (UIButton *b in @[mich, iu, florida]) {
        [b addTarget:self action:@selector(didTapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:b];
    }
    
    mich.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4.f);
    iu.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4.f * 2.f);
    florida.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4.f * 3.f);
}

- (void)didTapBtn:(UIButton*)sender
{
    NSInteger tag = sender.tag;
    NSString *schoolCode;
    switch (tag) {
        case kMichiganButtonTag:
            schoolCode = @"umich";
            break;
            
        case kIUButtonTag:
            schoolCode = @"iu";
            break;

        case kFloridaButtonTag:
            schoolCode = @"florida";
            break;

        default:
            schoolCode = @"umich";
            break;
    }
    
    [[User sharedInstance] setSchool:schoolCode];

    /*
    [[NSUserDefaults standardUserDefaults] setValue:schoolCode forKey:kNSUDSchoolCodeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
     */
    
  
    [self presentViewController:self.cardIDViewController animated:YES completion:nil];

//    [self dismissViewControllerAnimated:YES completion:self.block];
}

- (void)didEnterCardID
{
    [self dismissViewControllerAnimated:YES completion:self.block];
}

@end
