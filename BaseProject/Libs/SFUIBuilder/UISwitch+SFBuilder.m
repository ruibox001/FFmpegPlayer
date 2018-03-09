//
//  UISwitch+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/4/24.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UISwitch+SFBuilder.h"
#import "SFUIBuilderDef.h"

@implementation UISwitch (SFBuilder)

- (SFPropertyUISwitchBoolBlock)switchValue {
    return ^(BOOL value){
        self.on = value;
        return self;
    };
}

- (SFPropertyUISwitchObjectBlock)switchOnColor {
    return ^(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.onTintColor = color;
        }
        return self;
    };
}

- (SFPropertyUISwitchObjectBlock)switchTinColor {
    return ^(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.tintColor = color;
        }
        return self;
    };
}

- (SFPropertyUISwitchObjectBlock)switchThumbColor {
    return ^(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.thumbTintColor = color;
        }
        return self;
    };
}

- (SFPropertyUISwitchObjectBlock)switchOnImg {
    return ^(id img){
        if ([img isKindOfClass:[NSString class]]) {
            self.onImage = [UIImage imageNamed:img];
        }
        else if ([img isKindOfClass:[UIImage class]]) {
            self.onImage = img;
        }
        return self;
    };
}

- (SFPropertyUISwitchObjectBlock)switchOffImg {
    return ^(id img){
        if ([img isKindOfClass:[NSString class]]) {
            self.offImage = [UIImage imageNamed:img];
        }
        else if ([img isKindOfClass:[UIImage class]]) {
            self.offImage = img;
        }
        return self;
    };
}

@end
