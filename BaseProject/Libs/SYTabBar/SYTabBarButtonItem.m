//
//  SYTabBarController.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYTabBarButtonItem.h"
#import "SYTabBarModel.h"

#define msgCountMaxWH 18
#define msgCountMinWH 8

@implementation SYTabBarButtonItem

- (id)initWithFrame:(CGRect)frame itemInfo:(SYTabBarModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        if (model.type == TabBarImageTypeOnlyImage) {
            UIImage *image = [UIImage imageNamed:model.tarBarImageNormal];
            
            CGFloat maxH = frame.size.height - 12;
            CGFloat imageH = image.size.height > maxH ? maxH : image.size.height;
            CGFloat imageW = image.size.width / image.size.height * imageH;
            self.onlyImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-imageW)/2, (frame.size.height-imageH)/2, imageW, imageH)];
            self.onlyImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.onlyImageView setImage:image];
            [self addSubview:self.onlyImageView];
            
            CGFloat msgWH = model.unReadType == UnReadCountStyleRedPoint? msgCountMinWH : msgCountMaxWH;
            self.msgCountLabel = [[SYUnReadView alloc]initWithFrame:CGRectMake(0, 0, msgWH, msgWH) style:model.unReadType];
            self.msgCountLabel.center = CGPointMake(CGRectGetMaxX(self.onlyImageView.frame)+3, self.onlyImageView.frame.origin.y+5);
            [self addSubview:self.msgCountLabel];
            [self.msgCountLabel setUnReadCount:model.tarBarUnReadCount];
        }
        else if (model.type == TabBarImageTypeImageTitle){
            UIImage *image = [UIImage imageNamed:model.tarBarImageNormal];
            CGFloat imageH = frame.size.height*0.5;
            CGFloat imageW = image.size.width / image.size.height * imageH;
            self.titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-imageW)/2, 5.5, imageW, imageH)];
            self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.titleImageView setImage:image];
            [self addSubview:self.titleImageView];

            CGFloat msgWH = model.unReadType == UnReadCountStyleRedPoint? msgCountMinWH : msgCountMaxWH;
            self.msgCountLabel = [[SYUnReadView alloc]initWithFrame:CGRectMake(0, 0, msgWH, msgWH) style:model.unReadType];
            self.msgCountLabel.center = CGPointMake(CGRectGetMaxX(self.titleImageView.frame)+3, self.titleImageView.frame.origin.y+5);
            [self addSubview:self.msgCountLabel];
            [self.msgCountLabel setUnReadCount:model.tarBarUnReadCount];
            
            self.titleTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.titleImageView.frame.origin.y+self.titleImageView.frame.size.height+4, frame.size.width, 12)];
            [self.titleTextLabel setText:model.tarBarName];
            [self.titleTextLabel setTextAlignment:NSTextAlignmentCenter];
            [self.titleTextLabel setBackgroundColor:[UIColor clearColor]];
            [self.titleTextLabel setTextColor:model.tarBarUnSelectColor];
            [self.titleTextLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
            [self addSubview:self.titleTextLabel];
        }
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    if (_model.type == TabBarImageTypeOnlyImage) {
        [self.onlyImageView setImage:selected?[UIImage imageNamed:_model.tarBarImagePress]:[UIImage imageNamed:_model.tarBarImageNormal]];
    }
    else if (_model.type == TabBarImageTypeImageTitle){
        [self.titleImageView setImage:selected?[UIImage imageNamed:_model.tarBarImagePress]:[UIImage imageNamed:_model.tarBarImageNormal]];
        [self.titleTextLabel setTextColor:selected?self.model.tarBarSelectColor:self.model.tarBarUnSelectColor];
    }
}

- (void) reloadData
{
    [self.msgCountLabel setUnReadCount:self.model.tarBarUnReadCount];
}

@end
