//
//  SFDispatchTimer.m
//  SofficeMoi
//
//  Created by Eayon on 16/12/9.
//  Copyright © 2016年 Soffice. All rights reserved.
//

#import "SFDispatchTimer.h"

@interface SFDispatchTimer ()

@property (nonatomic, strong) dispatch_source_t beatTimer;

@end

@implementation SFDispatchTimer

+ (instancetype)registerSeconds:(NSInteger)sec block:(dispatch_block_t)block
{
    return [[super alloc] initRegisterSeconds:sec block:block];
}

- (instancetype)initRegisterSeconds:(NSInteger)sec block:(dispatch_block_t)block
{
    self = [super init];
    if (self) {
        _beatTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_beatTimer, DISPATCH_TIME_NOW, sec * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_beatTimer, block);
    }
    return self;
}

- (void)stop {
    dispatch_source_cancel(self.beatTimer);
}

- (void)start {
    dispatch_resume(self.beatTimer);
}

@end
