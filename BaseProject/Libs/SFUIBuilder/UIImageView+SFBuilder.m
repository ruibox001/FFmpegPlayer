//
//  UIImageView+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIImageView+SFBuilder.h"

@implementation UIImageView (SFBuilder)

- (SFPropertyUIImageViewObjectBlock)imgViewImg {
    return ^ (id img) {
        if ([img isKindOfClass:[UIImage class]]) {
            self.image = img;
        }
        else if ([img isKindOfClass:[NSString class]]) {
            self.image = [UIImage imageNamed:img];
        }
        return self;
    };
}

- (SFPropertyUIImageViewIntBlock)imgViewMode {
    return ^ (NSInteger mode) {
        self.contentMode = mode;
        return self;
    };
}

@end
