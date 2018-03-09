//
//  SFUIBuilderDef.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/13.
//  Copyright © 2017年 王声远. All rights reserved.
//

#ifndef SFUIBuilderDef_h
#define SFUIBuilderDef_h

#import <objc/objc.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef struct SFRect {
    CGRect value;
} SFRect;

typedef struct SFPoint {
    CGPoint value;
} SFPoint;

typedef struct SFSize {
    CGSize value;
} SFSize;

#define FILESTR [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define SFLog(...) printf("%s 第%d行: %s\n", [FILESTR UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#define CFSTR(cStr)  ((CFStringRef) __builtin___CFStringMakeConstantString ("" cStr ""))

#define commonProp(_hex_)   ((__bridge NSString *)CFSTR(#_hex_))
#define commonProps(...)   ((__bridge NSString *)CFSTR(#__VA_ARGS__))

#define rect(...)  ((CGRect){__VA_ARGS__})
#define point(...)  ((CGPoint){__VA_ARGS__})
#define sizes(...)  ((CGSize){__VA_ARGS__})

/**
 * 定义各个控件的属性block
 */
#define SF_UI_PROP_TYPE(v, t)       typedef v *(^SFProperty##v##t##Block)
#define SF_GENERATE_PROP_TYPES(x) \
SF_UI_PROP_TYPE(x, Empty)();\
SF_UI_PROP_TYPE(x, Int)(NSInteger);\
SF_UI_PROP_TYPE(x, Bool)(BOOL);\
SF_UI_PROP_TYPE(x, Rect)(SFRect);\
SF_UI_PROP_TYPE(x, Object)(id);\
SF_UI_PROP_TYPE(x, String)(NSString *);\
SF_UI_PROP_TYPE(x, TwoObject)(id, id);\
SF_UI_PROP_TYPE(x, ThreeObject)(id, id, id);\
SF_UI_PROP_TYPE(x, IdTargetSel)(id, id, SEL);\
SF_UI_PROP_TYPE(x, TargetSel)(id, SEL);\
SF_UI_PROP_TYPE(x, Func)(SEL);\
SF_UI_PROP_TYPE(x, Float)(CGFloat);\
SF_UI_PROP_TYPE(x, Point)(SFPoint);\
SF_UI_PROP_TYPE(x, Size)(SFSize);\
SF_UI_PROP_TYPE(x, CSize)(CGSize);\
SF_UI_PROP_TYPE(x, CallBack)(id);

SF_GENERATE_PROP_TYPES(UILabel);
SF_GENERATE_PROP_TYPES(UIButton);
SF_GENERATE_PROP_TYPES(UIImageView);
SF_GENERATE_PROP_TYPES(UITextField);
SF_GENERATE_PROP_TYPES(UITextView);
SF_GENERATE_PROP_TYPES(UITableView);
SF_GENERATE_PROP_TYPES(UIScrollView);
SF_GENERATE_PROP_TYPES(UIView);
SF_GENERATE_PROP_TYPES(UISwitch);
SF_GENERATE_PROP_TYPES(NSString);
SF_GENERATE_PROP_TYPES(NSMutableAttributedString);
SF_GENERATE_PROP_TYPES(UIImage);
SF_GENERATE_PROP_TYPES(NSDictionary);
SF_GENERATE_PROP_TYPES(NSData);
SF_GENERATE_PROP_TYPES(NSDate);
SF_GENERATE_PROP_TYPES(NSDateFormatter);
SF_GENERATE_PROP_TYPES(NSArray);
SF_GENERATE_PROP_TYPES(UIViewController);
SF_GENERATE_PROP_TYPES(UIWebView);
SF_GENERATE_PROP_TYPES(WKWebView);
SF_GENERATE_PROP_TYPES(UINavigationController);
SF_GENERATE_PROP_TYPES(UIScrollView);
SF_GENERATE_PROP_TYPES(UICollectionView);
SF_GENERATE_PROP_TYPES(UISegmentedControl);
SF_GENERATE_PROP_TYPES(UIColor);
SF_GENERATE_PROP_TYPES(NSURL);

/**
 定义UI属性
 */
#define SF_READONLY                             @property (nonatomic, readonly)
#define SF_UIPROP_TYPE(x,y)                     SF_READONLY SFProperty##x##y##Block

#define SF_UILABEL_PROP(y)                      SF_UIPROP_TYPE(UILabel, y)
#define SF_UIBUTTON_PROP(y)                     SF_UIPROP_TYPE(UIButton, y)
#define SF_UIIMAGEVIEW_PROP(y)                  SF_UIPROP_TYPE(UIImageView, y)
#define SF_UITEXTFIELD_PROP(y)                  SF_UIPROP_TYPE(UITextField, y)
#define SF_UITEXTVIEW_PROP(y)                   SF_UIPROP_TYPE(UITextView, y)
#define SF_UITABLEVIEW_PROP(y)                  SF_UIPROP_TYPE(UITableView, y)
#define SF_UISCROLLVIEW_PROP(y)                 SF_UIPROP_TYPE(UIScrollView, y)
#define SF_UIVIEW_PROP(y)                       SF_UIPROP_TYPE(UIView, y)
#define SF_UISWITCH_PROP(y)                     SF_UIPROP_TYPE(UISwitch, y)
#define SF_NSString_PROP(y)                     SF_UIPROP_TYPE(NSString, y)
#define SF_NSMutableAttributedString_PROP(y)    SF_UIPROP_TYPE(NSMutableAttributedString, y)
#define SF_UIImage_PROP(y)                      SF_UIPROP_TYPE(UIImage, y)
#define SF_NSDictionary_PROP(y)                 SF_UIPROP_TYPE(NSDictionary, y)
#define SF_NSData_PROP(y)                       SF_UIPROP_TYPE(NSData, y)
#define SF_NSDate_PROP(y)                       SF_UIPROP_TYPE(NSDate, y)
#define SF_NSDateFormatter_PROP(y)              SF_UIPROP_TYPE(NSDateFormatter, y)
#define SF_NSArray_PROP(y)                      SF_UIPROP_TYPE(NSArray, y)
#define SF_UIViewController_PROP(y)             SF_UIPROP_TYPE(UIViewController, y)
#define SF_UIWebView_PROP(y)                    SF_UIPROP_TYPE(UIWebView, y)
#define SF_WKWebView_PROP(y)                    SF_UIPROP_TYPE(WKWebView, y)
#define SF_UINavigationController_PROP(y)       SF_UIPROP_TYPE(UINavigationController, y)
#define SF_UIScrollView_PROP(y)                 SF_UIPROP_TYPE(UIScrollView, y)
#define SF_UICollectionView_PROP(y)             SF_UIPROP_TYPE(UICollectionView, y)
#define SF_UISegmentedControl_PROP(y)             SF_UIPROP_TYPE(UISegmentedControl, y)
#define SF_UIColor_PROP(y)                      SF_UIPROP_TYPE(UIColor, y)
#define SF_NSURL_PROP(y)                        SF_UIPROP_TYPE(NSURL, y)

/**
 返回属性block
 */
#define SF_DO_BLOCK(x, ...) return ^(x value) {__VA_ARGS__; return self;}
#define SF_EMPTY_BLOCK(...)        return ^{__VA_ARGS__; return self;}
#define SF_OBJECT_BLOCK(...)       SF_DO_BLOCK(id, __VA_ARGS__)
#define SF_INT_BLOCK(...)          SF_DO_BLOCK(NSInteger, __VA_ARGS__)
#define SF_FLOAT_BLOCK(...)        SF_DO_BLOCK(CGFloat, __VA_ARGS__)
#define SF_RECT_BLOCK(...)         SF_DO_BLOCK(SFRect, __VA_ARGS__)
#define SF_FUNC_BLOCK(...)         SF_DO_BLOCK(SEL, __VA_ARGS__)

#define SF_CALLBACK_BLOCK(...)     return ^(id target, id object) {__weak id weakTarget = target; __weak id weakSelf = self; __VA_ARGS__; weakTarget = nil; weakSelf = nil; return self;}


#define SF_DOS_BLOCK(t)  return ^() {t(); return self;}

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define weakObject(type)  __weak typeof(type) weak##type = type;
#define strongObject(type)  __strong typeof(type) strong##type = weak##type;

#endif /* SFUIBuilderDef_h */
