//
//  DKAlertView.h
//  DAVKIT
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKAlertInputView : UIAlertView <UIAlertViewDelegate>
{
	UITextField *textField;
}
@property(nonatomic,retain) UITextField *textField;
- (id)initWithTitle:(NSString *)title current:(NSString*)current placeHolder:(NSString*)placeHolder block:(void (^)(DKAlertInputView *inputView,NSString *text))block;
@end
