//
//  LCCardIDViewController.h
//  LegendsCard
//
//  Created by Lily Hashemi on 5/26/15.
//  Copyright (c) 2015 LegendsCard. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LCCardIDViewControllerDelegate;


@interface LCCardIDViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) BOOL animated;

@property (nonatomic, weak) id<LCCardIDViewControllerDelegate> delegate;

@end

@protocol LCCardIDViewControllerDelegate <NSObject>

- (void)didEnterCardID;

@end
