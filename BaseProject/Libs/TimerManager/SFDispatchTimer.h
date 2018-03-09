//
//  SFDispatchTimer.h
//  SofficeMoi
//
//  Created by Eayon on 16/12/9.
//  Copyright © 2016年 Soffice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFDispatchTimer : NSObject

+ (instancetype)registerSeconds:(NSInteger)sec block:(dispatch_block_t)block;
- (void)stop;
- (void)start;

@end
