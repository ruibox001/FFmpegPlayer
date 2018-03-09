//
//  SFAlphaMaker.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFAlphaMaker.h"

@implementation SFAlphaMaker

AlphaKer *alphaBuilder(){
    AlphaKer *a = AlphaKer.new;
    a.alphaColors = NSMutableArray.array;
    return a;
}

- (AlphaKer *(^)(UIColor *))addColor {
    return ^ (UIColor *color) {
        if (self.alphaColors) {
            [self.alphaColors addObject:color];
        }
        return self;
    };
}

- (AlphaKer *(^)(NSArray *))arrayColors {
    return ^ (NSArray *colors) {
        if (self.alphaColors) {
            [self.alphaColors addObjectsFromArray:colors];
        }
        return self;
    };
}

- (AlphaKer *(^)(NSArray *))arrayLocs {
    return ^ (NSArray *locs) {
        if (locs) {
            self.locs = [NSMutableArray arrayWithArray:locs];
        }
        return self;
    };
}

- (AlphaKer *(^)(SFPoint))addStartPoint {
    return ^ (SFPoint point) {
        _sPoint = point.value;
        return self;
    };
}

- (AlphaKer *(^)(SFPoint))addEndPoint {
    return ^ (SFPoint point) {
        _ePoint = point.value;
        return self;
    };
}

@end
