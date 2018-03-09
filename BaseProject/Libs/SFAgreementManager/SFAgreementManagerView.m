//
//  SFAgreetmentView.m
//  Tronker
//
//  Created by 王声远 on 2017/6/22.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "SFAgreementManagerView.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface SFAgreementManagerView()

@property (nonatomic,strong) UIButton *agreementBtn;
@property (nonatomic,strong) UIButton *protocolBtn;
@property (nonatomic,copy) void (^clickProtocolBlock)(UIButton *btn);

@end

@implementation SFAgreementManagerView

- (instancetype) initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor font:(UIFont *)font protocolClick:(void (^)(UIButton *btn))block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        WEAKSELF
        self.backgroundColor = [UIColor clearColor];
        self.clickProtocolBlock = block;
        
        self.agreementBtn = (UIButton *)Button.btnNorTitle(leftTitle).btnNorTitleColor(leftColor).btnFont(font).btnNorImage(@"agreement_status_unselect").btnSeleImage(@"agreement_status_select").btnTargetAction(self,@selector(clickBtn:)).viewTag(0).viewIntoView(self);
        [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
        self.protocolBtn = (UIButton *)Button.btnNorTitle(rightTitle).btnNorTitleColor(rightColor).btnFont(font).btnTargetAction(self,@selector(clickBtn:)).viewTag(1).viewIntoView(self);
        [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.agreementBtn.mas_right);
            make.centerY.equalTo(weakSelf.agreementBtn.mas_centerY);
        }];

        
    }
    return self;
}

- (void)clickBtn:(UIButton *)btn {
    if (self.clickProtocolBlock) {
        self.self.clickProtocolBlock(btn);
    }
}

- (BOOL)agreeProtocol
{
    return self.agreementBtn.selected;
}

- (void)setAgreeStatus:(BOOL)status
{
    DLog(@"%d 1setAgreeStatus: %d",self.agreementBtn.selected,status);
    self.agreementBtn.selected = status;
    DLog(@"%d 2setAgreeStatus: %d",self.agreementBtn.selected,status);
}

@end
