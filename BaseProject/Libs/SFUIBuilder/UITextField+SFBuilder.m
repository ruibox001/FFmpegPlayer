//
//  UITextField+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UITextField+SFBuilder.h"

@implementation UITextField (SFBuilder)

- (SFPropertyUITextFieldObjectBlock)textFieldColor {
    return ^ (id color) {
        if ([color isKindOfClass:[UIColor class]]) {
            self.textColor = color;
            [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        }
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldDelegat {
    return ^ (id delegat) {
        if (delegat) {
            self.delegate = delegat;
        }
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldFont
{
    return ^(id font){
        if ([font isKindOfClass:[UIFont class]]) {
            self.font = font;
        }
        return self;
    };
}

- (SFPropertyUITextFieldIntBlock)textFieldClearBtnMode
{
    return ^(NSInteger mode){
        self.clearButtonMode = mode;
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldPlaceHoder {
    return ^ (id holderStr) {
        if ([holderStr isKindOfClass:[NSString class]]) {
            self.placeholder = holderStr;
        }
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldLeftView {
    return ^ (id leftView) {
        if ([leftView isKindOfClass:[UIView class]]) {
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = leftView;
        }
        return self;
    };
}

- (SFPropertyUITextFieldEmptyBlock)textFieldNullLeftView
{
    return ^(){
        self.textFieldLeftView([[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)]);
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldRightView {
    return ^ (id rightView) {
        if ([rightView isKindOfClass:[UIView class]]) {
            self.rightViewMode = UITextFieldViewModeAlways;
            self.rightView = rightView;
        }
        return self;
    };
}

- (SFPropertyUITextFieldFloatBlock)textFieldLeftViewOffset {
    return ^(CGFloat offset){
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, offset, self.frame.size.height)];
        self.leftViewMode = UITextFieldViewModeAlways;
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldFinishBtn {
    return ^ (id finishBtn) {
        if ([finishBtn isKindOfClass:[UIButton class]]) {
            [finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
            [self setInputAccessoryView:finishBtn];
        }
        return self;
    };
}

- (void)finishClick
{
    [self endEditing:YES];
}

- (SFPropertyUITextFieldObjectBlock)textFieldPlaceholderColor {
    return  ^(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            UIColor *c = color;
            [self setValue:c forKeyPath:@"_placeholderLabel.textColor"];
        }
        return self;
    };
}

- (SFPropertyUITextFieldObjectBlock)textFieldPlaceholderFont {
    return ^(id font) {
        if ([font isKindOfClass:[UIFont class]]) {
            UIFont *c = font;
            [self setValue:c forKeyPath:@"_placeholderLabel.font"];
        }
        return self;
    };
}

- (SFPropertyUITextFieldIntBlock)textFieldKeyType {
    return ^(NSInteger type){
        self.returnKeyType = type;
        return self;
    };
}

@end
