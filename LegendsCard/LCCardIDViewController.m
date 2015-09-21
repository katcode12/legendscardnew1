//
//  LCCardIDViewController.m
//  LegendsCard
//
//  Created by Lily Hashemi on 5/26/15.
//  Copyright (c) 2015 LegendsCard. All rights reserved.
//

#import "LCCardIDViewController.h"
#import "LCEmailViewController.h"
#import "User.h"
#import "SVProgressHUD.h"

@interface LCCardIDViewController ()

@property (strong, nonatomic) UITextField *idTextField;
@property (strong, nonatomic) UILabel* lblWarning;

@property (nonatomic) BOOL enteredCardId;
@property (strong, nonatomic) LCEmailViewController *emailVC;

@end

@implementation LCCardIDViewController


- (id)init
{
    self = [super init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    self.enteredCardId = false;
    self.emailVC = [[LCEmailViewController alloc] init];
    self.emailVC.delegate = self;
    
    [self setupView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.idTextField.text = @"";
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.idTextField resignFirstResponder];
}

-(void)keyboardWillShow {
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect rectScreen = [[UIScreen mainScreen] bounds];
    
    if (textField == self.idTextField) {
        [UIView animateWithDuration:0.3f animations:^ {
            self.view.frame = CGRectMake(0, -80, rectScreen.size.width, rectScreen.size.height);
        }];
        self.animated = YES;
    }
 
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)keyboardWillHide {
    CGRect rectScreen = [[UIScreen mainScreen] bounds];
    
    // Animate the current view back to its original position
    if (self.animated) {
        [UIView animateWithDuration:0.3f animations:^ {
            self.view.frame = CGRectMake(0, 0, rectScreen.size.width, rectScreen.size.height);
        }];
        self.animated = NO;
    }
}


- (void)setupView
{
    
    UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    [idLabel setTextAlignment:NSTextAlignmentCenter];
    [idLabel setNumberOfLines:0];
    [idLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [idLabel setBackgroundColor:[UIColor clearColor]];
    [idLabel setTextColor:[UIColor colorWithRed:91./255. green:91./255. blue:91./255. alpha:1.]];
    [idLabel setFont:[UIFont fontWithName:@"Cubano-Regular" size:35]];
    [idLabel setText:@"Enter Card ID Number"];
    [self.view addSubview:idLabel];
    
    UITextField *textField = [[UITextField alloc] init];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField setDelegate:self];
    [self setIdTextField:textField];
    [self.view addSubview:self.idTextField];
    textField.delegate = self;

    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textField
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeading multiplier:1.0 constant:50]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textField
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-50]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textField
                              attribute:NSLayoutAttributeTopMargin
                              relatedBy:NSLayoutRelationEqual
                              toItem:idLabel
                              attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textField
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25]];
    
    [self setupButton];
    
}

- (void)setupButton
{
    UILabel *idWarning = [[UILabel alloc] init];
    [idWarning setTranslatesAutoresizingMaskIntoConstraints:NO];
    [idWarning setTextAlignment:NSTextAlignmentCenter];
    [idWarning setNumberOfLines:0];
    [idWarning setLineBreakMode:NSLineBreakByWordWrapping];
    [idWarning setBackgroundColor:[UIColor clearColor]];
    [idWarning setTextColor:[UIColor redColor]];
    [idWarning setFont:[UIFont fontWithName:@"Cubano-Regular" size:13.f]];
    [idWarning setText:@"This id is already registered!"];
    [self setLblWarning:idWarning];
    [self.view addSubview:idWarning];
    idWarning.hidden = YES;
    
    UIButton *submitButton = [[UIButton alloc] init];
    [submitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [submitButton setBackgroundColor:[UIColor blueColor]];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    
    [self.view addSubview:submitButton];

    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:idWarning attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.idTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];

    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:submitButton attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.idTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:submitButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:100]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:submitButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-100]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:submitButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    
    [submitButton addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchDown];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)exitKeyboard:(UITapGestureRecognizer *)recognizer {
    
    if ([_idTextField isFirstResponder]) {
        [_idTextField resignFirstResponder];
    }
}

- (void) hideWarningLabel
{
    self.lblWarning.hidden = YES;
}

- (void)submitButtonPressed {
    [self.idTextField resignFirstResponder];

    if (self.idTextField.text.length == 0)
    {
        self.lblWarning.hidden = NO;
        self.lblWarning.text = @"Please input card id";
        [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
        return;
    }

    if (self.idTextField.text.length != 6)
    {
        self.lblWarning.hidden = NO;
        self.lblWarning.text = @"Please valid card id";
        [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
        return;
    }
    else if (![[self.idTextField.text substringToIndex:1] isEqualToString:@"3"])
    {
        self.lblWarning.hidden = NO;
        self.lblWarning.text = @"Please valid card id";
        [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
        return;
    }
    
    self.lblWarning.hidden = YES;
    
    [self performSelector:@selector(doProcess) withObject:nil afterDelay:0.6f];
}

- (void) doProcess
{
    //check whether id exists in db
    [SVProgressHUD showWithStatus:@"Checking..." maskType:SVProgressHUDMaskTypeGradient];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LegendsCards"];
    [query whereKey:@"CardNumber" equalTo:self.idTextField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu users.", (unsigned long)objects.count);
            // Do something with the found objects
            if (objects.count > 0)
            {
                //login
                self.lblWarning.hidden = NO;
                self.lblWarning.text = @"This id is already registered.";
                [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
            }
            else
            {
                [[User sharedInstance] setLegendsNumber:self.idTextField.text];
                self.enteredCardId = YES;
                
                [self presentViewController:self.emailVC animated:YES completion:nil];
            }
        } else {
            [SVProgressHUD dismiss];
            self.lblWarning.hidden = NO;
            self.lblWarning.text = @"Network error! Please try later";
            [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
            
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)didEnterEmail {
    [self dismissViewControllerAnimated:NO completion:^(void) {
        [self.delegate didEnterCardID];
    }
     ];
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
