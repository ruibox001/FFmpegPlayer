//
//  UIButton+Builder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/13.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIButton+SFBuilder.h"


@implementation UIButton (SFBuilder)


- (SFPropertyUIButtonObjectBlock)btnNorTitle {
    return ^id (id title){
        if ([title isKindOfClass:[NSString class]]) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnNorImage {
    return ^(id img){
        if ([img isKindOfClass:[UIImage class]]) {
            [self setImage:img forState:UIControlStateNormal];
        }
        else if ([img isKindOfClass:[NSString class]]){
            [self setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnNorAttributeStr {
    return ^(id attributeStr){
        if ([attributeStr isKindOfClass:[NSAttributedString class]]) {
            [self setAttributedTitle:attributeStr forState:UIControlStateNormal];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnSeleTitle {
    return ^id (id sTitle){
        if ([sTitle isKindOfClass:[NSString class]]) {
            [self setTitle:sTitle forState:UIControlStateSelected];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnSeleImage {
    return ^(id img){
        if ([img isKindOfClass:[UIImage class]]) {
            [self setImage:img forState:UIControlStateSelected];
        }
        else if ([img isKindOfClass:[NSString class]]){
            [self setImage:[UIImage imageNamed:img] forState:UIControlStateSelected];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnSeleAttributeStr {
    return ^(id attributeStr){
        if ([attributeStr isKindOfClass:[NSAttributedString class]]) {
            [self setAttributedTitle:attributeStr forState:UIControlStateSelected];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnNorTitleColor {
    return ^id (id nColor){
        if ([nColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:nColor forState:UIControlStateNormal];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnSeleTitleColor {
    return ^id (id sColor){
        if ([sColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:sColor forState:UIControlStateSelected];
        }
        return self;
    };
}

- (SFPropertyUIButtonObjectBlock)btnFont {
    return ^id (id btnFont){
        if ([btnFont isKindOfClass:[UIFont class]]) {
            self.titleLabel.font = btnFont;
        }
        return self;
    };
}

- (SFPropertyUIButtonIntBlock)btnAlign {
    return ^(NSInteger l) {
        self.contentHorizontalAlignment = l;
        return self;
    };
}

- (SFPropertyUIButtonTargetSelBlock)btnTargetAction{
    return ^id (id target, SEL sel){
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

- (SFPropertyUIButtonBoolBlock)btnSelet {
    return ^id (BOOL selet){
        [self setSelected:selet];
        return self;
    };
}

@end
