//
//  SegmentedControl.m
//  ZHG
//
//  Created by lihong on 14-4-18.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SegmentedControl.h"
#import "UIColor+RGB.h"

@interface SegmentedControl()
@property (nonatomic, strong) UIView *indicatorView,*hairLine;
@property (nonatomic, strong) UILabel *selectedLable;
@property (nonatomic, strong) NSMutableArray *labelArray,*divideLineArray;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) id actionTarget;
@property (nonatomic, assign) SEL selector;
@end

@implementation SegmentedControl

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if(self)
    {
        self.items = items;
        self.backgroundColor = [UIColor r:242 g:242 b:242];
        self.labelArray = [[NSMutableArray alloc] initWithCapacity:self.items.count];
        self.divideLineArray = [[NSMutableArray alloc] initWithCapacity:self.items.count - 1];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    }
    
    return self;
}

- (void)layoutCustomSubviews
{
    
    if(self.hairLine && self.indicatorView && self.labelArray.count && self.divideLineArray.count)
    {
        [self.hairLine removeFromSuperview];
        [self.indicatorView removeFromSuperview];
        [self.labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(UIView *) obj removeFromSuperview];
        }];
        [self.divideLineArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(UIView *)obj removeFromSuperview];
        }];
    }
    
    NSUInteger count = self.items.count;
    CGSize size = self.bounds.size;
    CGRect bounds = CGRectMake(0, 0, size.width/count, size.height);
    
    for(NSUInteger i = 0; i < count; i++)
    {
        UILabel *lable = [[UILabel alloc] initWithFrame:bounds];
        lable.center = CGPointMake((size.width/count)*i + (size.width/count)/2, size.height/2);
        lable.text = self.items[i];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        [self.labelArray addObject:lable];
    }
    
    bounds = CGRectMake(0, 0, 1, size.height/2);
    for(NSUInteger i = 0; i < count -1; i++)
    {
        UIView *divideLine = [[UIView alloc] initWithFrame:bounds];
        divideLine.center = CGPointMake((size.width/count)*i + (size.width/count), size.height/2);
        divideLine.backgroundColor = [UIColor r:236 g:236 b:236];
        [self addSubview:divideLine];
    }
    
    bounds = CGRectMake(0, size.height-2, size.width, 2);
    self.hairLine = [[UIView alloc] initWithFrame:bounds];
    self.hairLine.backgroundColor = [UIColor r:231 g:231 b:231];
    [self addSubview:self.hairLine];
    
    bounds = CGRectMake(0, size.height-2, size.width/count, 2);
    self.indicatorView = [[UIView alloc] initWithFrame:bounds];
    self.indicatorView.backgroundColor = [UIColor r:69 g:194 b:240];
    [self addSubview:self.indicatorView];
    
    self.selectedLable = [self.labelArray objectAtIndex:0];
    [self.selectedLable setTextColor:self.indicatorView.backgroundColor];
}

- (void)setSCFrame:(CGRect)frame
{
    self.frame = frame;
    [self layoutCustomSubviews];
}

- (void)setItemTitle:(NSString *)title for:(NSUInteger)itemIndex
{
    UILabel *l = [self.labelArray objectAtIndex:itemIndex];
    [l setText:title];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSUInteger count = self.labelArray.count;
    CGSize size = self.bounds.size;
    CGPoint touchPoint = [touch locationInView:self];
    
    _selectedIndex = floorf(touchPoint.x/(size.width/count));
 
    [UIView animateWithDuration:0.15 animations:^{
        CGPoint center = self.indicatorView.center;
        center.x = (size.width/count)*_selectedIndex + (size.width/count)/2;
        self.indicatorView.center = center;
    }];
    
    UILabel *lable = [self.labelArray objectAtIndex:_selectedIndex];
    UIColor *color = self.selectedLable.textColor;
    self.selectedLable.textColor = lable.textColor;
    lable.textColor = color;
    self.selectedLable = lable;
    
    if(self.actionTarget && self.selector)
    {
        if([self.actionTarget respondsToSelector:self.selector])
        {
            [self.actionTarget performSelector:self.selector withObject:self];
        }
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if(controlEvents != UIControlEventValueChanged) return;
    self.actionTarget = target;
    self.selector = action;
}

- (void)hideIndicatorView:(BOOL)yesOrNo
{
    self.indicatorView.hidden = yesOrNo;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
