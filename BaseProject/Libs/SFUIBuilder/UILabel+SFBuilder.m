//
//  UILabel+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/13.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UILabel+SFBuilder.h"
#import "UIFont+SFBuilder.h"

@implementation UILabel (SFBuilder)

- (SFPropertyUILabelObjectBlock)labelText {
    return ^id (id text) {
        if ([text isKindOfClass:[NSString class]]) {
            self.text = text;
        }
        else if ([text isKindOfClass:[NSAttributedString class]]) {
            self.attributedText = text;
        }
        return self;
    };
}

- (SFPropertyUILabelObjectBlock)labelFont {
    return ^id (id labelFont) {
        if ([labelFont isKindOfClass:[UIFont class]]) {
            self.font = labelFont;
        }
        else if ([labelFont isKindOfClass:[NSNumber class]]) {
            self.font = Fnt(labelFont);
        }
        return self;
    };
}

- (SFPropertyUILabelObjectBlock)labelTextColor {
    return ^id (id labelTextColor) {
        if ([labelTextColor isKindOfClass:[UIColor class]]) {
            self.textColor = labelTextColor;
        }
        return self;
    };
}

- (SFPropertyUILabelIntBlock)labelAlign {
    return ^id (NSInteger alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

- (SFPropertyUILabelObjectBlock)labelmAttiStr {
    return ^id (id mutableAttibuteString) {
        if ([mutableAttibuteString isKindOfClass:[NSAttributedString class]]) {
            self.attributedText = mutableAttibuteString;
            [self sizeToFit];
        }
        return self;
    };
}

- (SFPropertyUILabelIntBlock)labelLineNum {
    return ^(NSInteger l) {
        self.numberOfLines = l;
        return self;
    };
}

- (SFPropertyUILabelObjectBlock)labelBottonLineWithColor {
    return ^id (id color) {
        if ([color isKindOfClass:[UIColor class]]) {
            
            
            
        }
        return self;
    };
}

- (SFPropertyUILabelObjectBlock)labelMiddleLineWithColor {
    return ^id (id color) {
        if ([color isKindOfClass:[UIColor class]]) {
            
            NSDictionary *attrs = @{NSFontAttributeName : self.font};
            CGSize stringSize = [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            
            // 画线居中(废弃线)
            CGRect lineRect = CGRectMake(0, stringSize.height/2, stringSize.width, 0.8);
            
            //开始画线
            UIColor *c = color;
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, c.CGColor);
            CGContextFillRect(context, lineRect);
            
        }
        return self;
    };
}

@end
