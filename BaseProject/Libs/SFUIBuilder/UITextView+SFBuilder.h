//
//  UITextView+SFBuilder.h
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

@interface UITextView (SFBuilder)

//- (void)addLeftBtn:(NSString *)imgName target:(id)target sel:(SEL)sec;
//- (void)addRightBtn:(NSString *)imgName target:(id)target sel:(SEL)sec;

SF_UITEXTVIEW_PROP(IdTargetSel) leftImgNameTargetSel;
SF_UITEXTVIEW_PROP(IdTargetSel) rightImgNameTargetSel;

@end
