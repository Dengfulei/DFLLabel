//
//  DFLLabelView.h
//  DFLLabel
//
//  Created by 杭州移领 on 16/7/5.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DFLLabelView;
@protocol DFLLabelViewDelegate <NSObject>

- (void)labelView:(DFLLabelView *)view DidClickLabelWithTitle:(NSString *)title;

@end
@interface DFLLabelView : UIView
/**标签文本数组*/
@property (nonatomic , strong) NSArray *texts ;
@property (nonatomic , copy) void (^clickLabelButtonBlock) (NSInteger index,NSString *tirtle);
@property (nonatomic ,assign) id<DFLLabelViewDelegate>delegate;

+ (CGFloat) getViewHeightWithArray:(NSArray *)array;
@end
