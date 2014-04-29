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
@property (nonatomic, strong) NSMutableArray *labelArray,*divideLineArray,*indicatorArray;
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
        self.itemTitleColor = [UIColor  r:232 g:110 b:95];
        self.itemTitleFont = [UIFont systemFontOfSize:17];
        self.labelArray = [[NSMutableArray alloc] initWithCapacity:self.items.count];
        self.divideLineArray = [[NSMutableArray alloc] initWithCapacity:self.items.count - 1];
        self.indicatorArray =[[NSMutableArray alloc] initWithCapacity:self.items.count];
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
        lable.textColor = self.itemTitleColor;
        lable.font = self.itemTitleFont;
        [self addSubview:lable];
        [self.labelArray addObject:lable];
    }
    
    for(NSUInteger i = 0; i < count; i++)
    {
        [self insertIndicatorWithImageName:@"segmented_indicator_default" atIndex:i];
    }
    
    bounds = CGRectMake(0, 0, 1, size.height/2);
    for(NSUInteger i = 0; i < count -1; i++)
    {
        UIView *divideLine = [[UIView alloc] initWithFrame:bounds];
        divideLine.center = CGPointMake((size.width/count)*i + (size.width/count), size.height/2);
        divideLine.backgroundColor = [UIColor r:170 g:170 b:170];
        [self addSubview:divideLine];
    }
    
    bounds = CGRectMake(0, size.height-1, size.width, 1);
    self.hairLine = [[UIView alloc] initWithFrame:bounds];
    self.hairLine.backgroundColor = [UIColor r:231 g:231 b:231];
    [self addSubview:self.hairLine];
    
    bounds = CGRectMake(0, size.height-2, size.width/count, 2);
    self.indicatorView = [[UIView alloc] initWithFrame:bounds];
    self.indicatorView.backgroundColor = [UIColor r:69 g:194 b:240];
    [self addSubview:self.indicatorView];
    
    UILabel *selectedLable = [self.labelArray objectAtIndex:0];
    [selectedLable setTextColor:self.indicatorView.backgroundColor];
}

- (void)setSCFrame:(CGRect)frame
{
    self.frame = frame;
    [self layoutCustomSubviews];
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    _itemTitleColor = itemTitleColor;
    [self.labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(idx != self.selectedIndex)
        {
            [(UILabel *)obj setTextColor:_itemTitleColor];
        }
    }];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont
{
    _itemTitleFont = itemTitleFont;
    [self.labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UILabel *)obj setFont:_itemTitleFont];
    }];
}

- (void)setItemTitle:(NSString *)title for:(NSUInteger)itemIndex
{
    UILabel *l = [self.labelArray objectAtIndex:itemIndex];
    [l setText:title];
}

- (void)insertIndicatorWithImageName:(NSString *)imageName atIndex:(NSUInteger)index
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:image];
    indicatorView.contentMode = UIViewContentModeCenter;
    
    NSUInteger count = self.items.count;
    if(index >= count) return;
    
    CGRect newRect = self.bounds;
    newRect.size.width /= count;
    newRect.origin.x = (index * newRect.size.width)-newRect.size.height+newRect.size.width;
    newRect.size.width = newRect.size.height;
    
    indicatorView.frame  = newRect;
    [self addSubview:indicatorView];
    [self.indicatorArray insertObject:indicatorView atIndex:index];
}

- (void)removeIndicatorAtIndex:(NSUInteger)index
{
    if(index >= self.indicatorArray.count) return;
    id indicator = [self.indicatorArray objectAtIndex:index];
    if([[indicator class] isSubclassOfClass:[NSNull class]] == NO)
    {
        [(UIImageView *)indicator removeFromSuperview];
    }
}

- (void)removeAllIndicator
{
    for(NSUInteger i=0 ; i < self.indicatorArray.count; i++)
    {
        [self removeIndicatorAtIndex:i];
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSUInteger count = self.labelArray.count;
    CGSize size = self.bounds.size;
    CGPoint touchPoint = [touch locationInView:self];
    
    NSUInteger index = floorf(touchPoint.x/(size.width/count));
 
    [UIView animateWithDuration:0.15 animations:^{
        CGPoint center = self.indicatorView.center;
        center.x = (size.width/count)*index + (size.width/count)/2;
        self.indicatorView.center = center;
    }];
    
    UILabel *lable = [self.labelArray objectAtIndex:index];
    UILabel *selectedLable = [self.labelArray objectAtIndex:_selectedIndex];
    UIColor *color = selectedLable.textColor;
    selectedLable.textColor = lable.textColor;
    lable.textColor = color;
    
    @try
    {
        UIView *indicator1 = [self.indicatorArray objectAtIndex:_selectedIndex];
        UIView *indicator2 = [self.indicatorArray objectAtIndex:index];
        [UIView animateWithDuration:0.15 animations:^{
            if(indicator1 != NULL) indicator1.transform = CGAffineTransformIdentity;
            if(indicator2 != NULL) indicator2.transform = CGAffineTransformMakeRotation(3.1415926);
        }];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception.callStackSymbols.debugDescription);
    }

    _selectedIndex = index;
    
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
