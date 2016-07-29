//
//  DHGridView.m
//  CreditDemand
//
//  Created by XuXg on 16/1/10.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "DHGridView.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)


@implementation DHGridView
@synthesize gridColor = _gridColor;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _gridColor = [UIColor blueColor];
        _gridLineWidth = SINGLE_LINE_WIDTH;
        _gridSize = CGSizeMake(30, 30);
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}
- (void)setGridColor:(UIColor *)gridColor
{
    _gridColor = gridColor;
    [self setNeedsDisplay];
}
- (void)setGridSize:(CGSize)gridSize
{
    _gridSize = gridSize;
    [self setNeedsDisplay];
}
- (void)setGridLineWidth:(CGFloat)gridLineWidth
{
    _gridLineWidth = gridLineWidth;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    CGFloat pixelAdjustOffset = 0;
    if (((int)(self.gridLineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    CGFloat xPos = ceil(_gridSize.width) - pixelAdjustOffset;
    CGFloat yPos = ceil(_gridSize.height) - pixelAdjustOffset;
    while (xPos < self.bounds.size.width) {
        CGContextMoveToPoint(context, xPos, 0);
        CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
        xPos += _gridSize.width;
    }
    
    while (yPos < self.bounds.size.height) {
        CGContextMoveToPoint(context, 0, yPos);
        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
        yPos += _gridSize.height;
    }
    
    CGContextSetLineWidth(context, _gridLineWidth);
    CGContextSetStrokeColorWithColor(context, _gridColor.CGColor);
    CGContextStrokePath(context);
}

@end
