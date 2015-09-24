//
//  LCEmailViewController.m
//  LegendsCard
//
//  Created by Lily Hashemi on 5/27/15.
//  Copyright (c) 2015 LegendsCard. All rights reserved.
//

#import "LCEmailViewController.h"
#import "User.h"
#import "SVProgressHUD.h"

@interface LCEmailViewController ()

@property (strong, nonatomic) UITextField *emailTxtField;
@property (assign) BOOL enteredEmail;

@property (strong, nonatomic) UILabel* lblWarning;

@end

@implementation LCEmailViewController

- (id)init
{
    self = [super init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    self.enteredEmail = false;
    [self setupView];
    
}

-(BOOL)validateEmail:(NSString*)strEmail
{
    if( (0 != [strEmail rangeOfString:@"@"].length) &&  (0 != [strEmail rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [strEmail rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        NSString *usernamePart = [strEmail substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainPart = [strEmail substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else
        return NO;
}

- (void)setupView
{
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, 100)];
    [emailLabel setTextAlignment:NSTextAlignmentCenter];
    [emailLabel setNumberOfLines:0];
    [emailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [emailLabel setBackgroundColor:[UIColor clearColor]];
    [emailLabel setTextColor:[UIColor colorWithRed:91./255. green:91./255. blue:91./255. alpha:1.]];
    [emailLabel setFont:[UIFont fontWithName:@"Cubano-Regular" size:35]];
    [emailLabel setText:@"Enter Email"];
    [self.view addSubview:emailLabel];
    
    UITextField *textField = [[UITextField alloc] init];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setDelegate:self];
    [self setEmailTxtField:textField];
    [self.view addSubview:self.emailTxtField];
    
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
                              toItem:emailLabel
                              attribute:NSLayoutAttributeBottom multiplier:1.0 constant:35]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textField
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25]];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self setupButton];
    
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
    
    self.emailTxtField.text = @"";
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.emailTxtField resignFirstResponder];
}

-(void)keyboardWillShow {
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect rectScreen = [[UIScreen mainScreen] bounds];
    
    if (textField == self.emailTxtField) {
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

- (void)setupButton
{
    UILabel *idWarning = [[UILabel alloc] init];
    [idWarning setTranslatesAutoresizingMaskIntoConstraints:NO];
    [idWarning setTextAlignment:NSTextAlignmentCenter];
    [idWarning setNumberOfLines:0];
    [idWarning setLineBreakMode:NSLineBreakByWordWrapping];
    [idWarning setBackgroundColor:[UIColor clearColor]];
    [idWarning setTextColor:[UIColor redColor]];
    [idWarning setFont:[UIFont fontWithName:@"Cubano-Regular" size:12.f]];
    [idWarning setText:@"Invalid email address"];
    [self setLblWarning:idWarning];
    [self.view addSubview:idWarning];
    idWarning.hidden = YES;
    
    UIButton *submitButton = [[UIButton alloc] init];
    [submitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [submitButton setBackgroundColor:[UIColor blueColor]];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    
    [self.view addSubview:submitButton];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:idWarning attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.emailTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:idWarning attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];

    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:submitButton attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.emailTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60]];
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
    
    if ([_emailTxtField isFirstResponder]) {
        [_emailTxtField resignFirstResponder];
    }
}

- (void) hideWarningLabel
{
    self.lblWarning.hidden = YES;
}

- (void)submitButtonPressed {
    [self.emailTxtField resignFirstResponder];

    if (self.emailTxtField.text.length == 0)
    {
        self.lblWarning.hidden = NO;
        self.lblWarning.text = @"Please input email";
        [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
        return;
    }
    
    if (![self validateEmail:self.emailTxtField.text])
    {
        self.lblWarning.hidden = NO;
        self.lblWarning.text = @"Please input valid email";
        [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
        return;
    }
    
    self.lblWarning.hidden = YES;

    [self performSelector:@selector(doProcess) withObject:nil afterDelay:0.6f];
}

- (void) doProcess
{
    //save them to DB
    [[User sharedInstance] setEmail:self.emailTxtField.text];
    self.enteredEmail = true;
    
    [SVProgressHUD showWithStatus:@"Registering..." maskType:SVProgressHUDMaskTypeGradient];

    NSString* strObjectId = [[NSUserDefaults standardUserDefaults] valueForKey:@"objectId"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LegendsCards"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:strObjectId
                                 block:^(PFObject *cardObject, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     if (error)
                                     {
                                         [SVProgressHUD dismiss];
                                         self.lblWarning.hidden = NO;
                                         self.lblWarning.text = @"Can't find object! Please try later.";
                                         [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
                                     }
                                     else
                                     {
                                         cardObject[@"Email"] = ((User *)[User sharedInstance]).email;
                                         cardObject[@"isRegistered"] = [NSNumber numberWithBool:true];
                                         [cardObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                             if (succeeded) {
                                                 [SVProgressHUD dismiss];
                                                 
                                                 [[NSUserDefaults standardUserDefaults] setValue:((User *)[User sharedInstance]).school forKey:kNSUDSchoolCodeKey];
                                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                                 
                                                 [self dismissViewControllerAnimated:NO completion:^(void){
                                                     [self.delegate didEnterEmail];
                                                 }];
                                                 
                                             } else {
                                                 // There was a problem, check error.description
                                                 [SVProgressHUD dismiss];
                                                 self.lblWarning.hidden = NO;
                                                 self.lblWarning.text = @"Network error! Please try later.";
                                                 [self performSelector:@selector(hideWarningLabel) withObject:nil afterDelay:1.2f];
                                             }
                                         }];
                                     }
                                 
    }];
    
    self.lblWarning.hidden = YES;
    //check whether id exists in db
    
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
