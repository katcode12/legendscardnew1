//
//  LCEmailViewController.h
//  LegendsCard
//
//  Created by Lily Hashemi on 5/27/15.
//  Copyright (c) 2015 LegendsCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCEmailViewControllerDelegate;

@interface LCEmailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<LCEmailViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL animated;

@end

@protocol LCEmailViewControllerDelegate <NSObject>

- (void)didEnterEmail;

@end