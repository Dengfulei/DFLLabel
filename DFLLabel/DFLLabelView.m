//
//  DFLLabelView.m
//  DFLLabel
//
//  Created by 杭州移领 on 16/7/5.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import "DFLLabelView.h"
#define START_X   10.f              //起始x位置
#define HORIZONTAL_PADDING 10.0f     //  字体距离标签左右两边间隙
#define VERTICAL_PADDING   5.0f    //  字体距离标签上下两边间隙
#define LABEL_PADDING       10.0f    //  标签之间的间隙
@interface DFLLabelView()

{
    CGRect previousFrame; /**记录上一个标签的frame*/
}

@end
@implementation DFLLabelView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

    
    }
    return self;
}

- (void)setTexts:(NSArray *)texts {
    
    _texts = texts;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_texts.count == 0) {
        [self setViewHightWithHight:0];
        return;
    }
    previousFrame = CGRectZero;
    previousFrame.origin.y = LABEL_PADDING;
    [_texts enumerateObjectsUsingBlock:^(NSString *title,NSUInteger idx,BOOL *stop) {
        UIButton *button = [self configuratioButtonWithIndex:idx title:title];
        [self addSubview:button];
        CGSize title_Size = [title sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        title_Size.width  += HORIZONTAL_PADDING;
        title_Size.height += VERTICAL_PADDING;
        CGRect currentLabelFrame = CGRectZero;
        if (previousFrame.origin.x + previousFrame.size.width + title_Size.width > self.bounds.size.width - 2 * START_X) {
           
            currentLabelFrame.origin = CGPointMake(START_X, CGRectGetMaxY(previousFrame) + LABEL_PADDING);

        } else {
           
            currentLabelFrame.origin = CGPointMake(CGRectGetMaxX(previousFrame)+ LABEL_PADDING, CGRectGetMinY(previousFrame));
        }
        currentLabelFrame.size = title_Size;
        button.frame = currentLabelFrame;
        previousFrame = currentLabelFrame;
        
    }];
    [self setViewHightWithHight:CGRectGetMaxY(previousFrame) + LABEL_PADDING];
}

- (void)setViewHightWithHight:(CGFloat)hight
{
    CGRect tempFrame = self.frame;
    
    tempFrame.size.height = hight;
    
    self.frame = tempFrame;
}

- (UIButton *) configuratioButtonWithIndex:(NSInteger)index title:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] init];
    button.tag = 100 +index;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.masksToBounds = YES;
   
    return button;
}


- (void)click:(UIButton *)button {
    
    NSLog(@"%ld",button.tag);
    if (self.clickLabelButtonBlock) {
        self.clickLabelButtonBlock(button.tag,[button titleForState:UIControlStateNormal]);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(labelView:DidClickLabelWithTitle:)]) {
        [_delegate labelView:self DidClickLabelWithTitle:[button titleForState:UIControlStateNormal]];
    }
}

+ (CGFloat) getViewHeightWithArray:(NSArray *)array {
    __block CGRect  previousFrame = CGRectZero;
    previousFrame.origin.y = LABEL_PADDING;
    [array enumerateObjectsUsingBlock:^(NSString *text,NSUInteger idx,BOOL *stop){
        
        CGSize size_str = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        size_str.width  += HORIZONTAL_PADDING;
        size_str.height += VERTICAL_PADDING;
        CGRect newFrame = CGRectZero;
        if (previousFrame.origin.x + previousFrame.size.width + size_str.width  > [UIScreen mainScreen].bounds.size.width - 2 * START_X) {
            newFrame.origin = CGPointMake(10, previousFrame.origin.y + previousFrame.size.height +LABEL_PADDING);
        } else {
            newFrame.origin = CGPointMake(CGRectGetMaxX(previousFrame)+ LABEL_PADDING, CGRectGetMinY(previousFrame));
        }
        newFrame.size = size_str;
        previousFrame = newFrame;
        
    }];
    return CGRectGetMaxY(previousFrame) + LABEL_PADDING;
}


@end
