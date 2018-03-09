//
//  SFAgreetmentView.h
//  Tronker
//
//  Created by 王声远 on 2017/6/22.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFAgreementManagerView : UIView

/**
 * frame        该View的frame
 * leftTitle    左边的title
 * rightTitle   右边的title
 * leftColor    左边的title的颜色
 * rightColor   右边的title的颜色
 * font         title的font
 * block        点击同意或不同意的block
 */
- (instancetype) initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor font:(UIFont *)font protocolClick:(void (^)(UIButton *btn))block;

/**
 * agreeProtocol 是否同意协议
 */
- (BOOL)agreeProtocol;

- (void)setAgreeStatus:(BOOL)status;

@end
