//
//  ADDrawingView.m
//  L24_drawing
//
//  Created by A D on 1/13/14.
//  Copyright (c) 2014 AD. All rights reserved.
//

#import "ADDrawingView.h"

@implementation ADDrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"RECT = %@", NSStringFromCGRect(rect));

    CGContextRef context = UIGraphicsGetCurrentContext();

    //draw stars, note draw circles method is called inside of drawStars
    //and connecting lines are drawn inside of drawCircles
    for(int i = 0; i<5; i++){
        
        CGFloat starRectSide = (arc4random() % 51) + 50;
        
        CGPoint origin = CGPointMake((arc4random() % (int)(CGRectGetWidth(self.bounds) - 100)),
                                     (arc4random() % (int)(CGRectGetHeight(self.bounds) - 100)));
        CGRect starRect;
        
        starRect.origin = origin;
        
        starRect.size = CGSizeMake(starRectSide, starRectSide);
        
        [self drawStarInRect:starRect withColor:[self randomColor] inContext:context];
    }
    
    //CGContextAddRect(context, starRect);
    
    //CGRect starRect1 = CGRectMake(0, 0, starRectSide, starRectSide);
    
    //CGContextStrokePath(context);


    //[self drawStarInRect:starRect1 withColor:[UIColor greenColor] inContext:context];

    //CGContextAddLineToPoint(context, CGRectGetMidX(starRect), CGRectGetMinY(starRect));
    
    //CGContextStrokePath(context);
    //CGContextFillPath(context);
    
}

#pragma mark - Drawing -

-(void) drawStarInRect:(CGRect)starRect withColor:(UIColor*)color inContext:(CGContextRef)context{
    

    NSMutableArray *vertices = [NSMutableArray array];
    

    
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"Ball.png"]].CGColor);
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, CGRectGetMidX(starRect), CGRectGetMinY(starRect));
    
    CGPoint vert1 = CGPointMake(CGRectGetMidX(starRect), CGRectGetMinY(starRect));
    [vertices addObject:[NSValue valueWithCGPoint:vert1]];
    
    //1
    CGContextAddLineToPoint(context, CGRectGetMinX(starRect) + CGRectGetWidth(starRect)/2.8,
                            CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    //2
    CGContextAddLineToPoint(context, CGRectGetMinX(starRect),
                            CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    
    CGPoint vert2 = CGPointMake(CGRectGetMinX(starRect),
                                CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    [vertices addObject:[NSValue valueWithCGPoint:vert2]];
    
    //3
    CGContextAddLineToPoint(context, CGRectGetMinX(starRect) + CGRectGetWidth(starRect)/3.5,
                            CGRectGetMaxY(starRect) - CGRectGetHeight(starRect)/2.5);
    //4
    CGContextAddLineToPoint(context, CGRectGetMinX(starRect) + CGRectGetWidth(starRect)/6,
                            CGRectGetMaxY(starRect));
    
    CGPoint vert3 = CGPointMake(CGRectGetMinX(starRect) + CGRectGetWidth(starRect)/6,
                                CGRectGetMaxY(starRect));
    [vertices addObject:[NSValue valueWithCGPoint:vert3]];
    
    //5
    CGContextAddLineToPoint(context, CGRectGetMidX(starRect),
                            CGRectGetMaxY(starRect) - CGRectGetHeight(starRect)/4);
    //6
    CGContextAddLineToPoint(context, CGRectGetMaxX(starRect) - CGRectGetWidth(starRect)/6,
                            CGRectGetMaxY(starRect));
    
    CGPoint vert4 = CGPointMake(CGRectGetMaxX(starRect) - CGRectGetWidth(starRect)/6,
                                CGRectGetMaxY(starRect));
    [vertices addObject:[NSValue valueWithCGPoint:vert4]];
    //7
    CGContextAddLineToPoint(context, CGRectGetMaxX(starRect) - CGRectGetWidth(starRect)/3.5,
                            CGRectGetMaxY(starRect) - CGRectGetHeight(starRect)/2.5);
    //8
    CGContextAddLineToPoint(context, CGRectGetMaxX(starRect),
                            CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    
    CGPoint vert5 = CGPointMake(CGRectGetMaxX(starRect),
                                CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    [vertices addObject:[NSValue valueWithCGPoint:vert5]];
    
    //9
    CGContextAddLineToPoint(context, CGRectGetMaxX(starRect) - CGRectGetWidth(starRect)/2.8,
                            CGRectGetMinY(starRect) + CGRectGetHeight(starRect)/3);
    //10
    CGContextAddLineToPoint(context, CGRectGetMidX(starRect),
                            CGRectGetMinY(starRect));
    
    CGContextClosePath(context);
    
    CGContextClip(context);
    
    
    //CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef) [NSData dataWithContentsOfFile:@"Ball.png"]);

    //CGDataProviderRef imageDataProvider = CGDataProviderCreateWithFilename("Ball.png");
    
    //CGImageRef image = CGImageCreateWithPNGDataProvider(imageDataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    UIImage *image = [UIImage imageNamed:@"Ball.png"];
    CGImageRef imageRef = [image CGImage];
    
    if (!image) {
        NSLog(@"NULL");
    }
    
    CGContextDrawImage(context, starRect, imageRef);
    
    //CGContextFillPath(context);
    
    //[self drawElipcesAtVertices:vertices inContext:context withStarRect:starRect];
}


-(void) drawElipcesAtVertices:(NSMutableArray*)vertices inContext:(CGContextRef)context withStarRect:(CGRect)starRect{
    
    NSMutableArray *elipseRects = [NSMutableArray array];
    
    for(NSValue *value in vertices){
        
        CGPoint vert = [value CGPointValue];
        
        CGRect elipseRect;
        
        elipseRect.origin = CGPointMake(vert.x - CGRectGetWidth(starRect)/10,
                                        vert.y - CGRectGetHeight(starRect)/10);
        
        elipseRect.size = CGSizeMake(CGRectGetWidth(starRect)/5, CGRectGetWidth(starRect)/5);
        
        [elipseRects addObject:[NSValue valueWithCGRect:elipseRect]];
        
        [self drawElipseInRect:elipseRect inContext:context andFillWithColor:[self randomColor]];
    }
    
        [self drawConnectionLinesWithRects:elipseRects inContext:context withLineWidth:3];
}

-(void) drawConnectionLinesWithRects:(NSMutableArray*)rects inContext:(CGContextRef)context withLineWidth:(NSInteger)width {
    
    //line one draw and stroke
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMinX([[rects objectAtIndex:0] CGRectValue]),
                         CGRectGetMidY([[rects objectAtIndex:0] CGRectValue]));
    
    CGContextAddLineToPoint(context, CGRectGetMidX([[rects objectAtIndex:1] CGRectValue]),
                            CGRectGetMinY([[rects objectAtIndex:1] CGRectValue]));
    
    CGContextStrokePath(context);
    
    //line two draw and stroke
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMidX([[rects objectAtIndex:1] CGRectValue]),
                         CGRectGetMaxY([[rects objectAtIndex:1] CGRectValue]));
    
    CGContextAddLineToPoint(context, CGRectGetMinX([[rects objectAtIndex:2] CGRectValue]),
                            CGRectGetMidY([[rects objectAtIndex:2] CGRectValue]));
    CGContextStrokePath(context);
    
    //line three draw and stroke
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMaxX([[rects objectAtIndex:2] CGRectValue]),
                         CGRectGetMidY([[rects objectAtIndex:2] CGRectValue]));
    
    CGContextAddLineToPoint(context, CGRectGetMinX([[rects objectAtIndex:3] CGRectValue]),
                            CGRectGetMidY([[rects objectAtIndex:3] CGRectValue]));
    CGContextStrokePath(context);
    
    //line four draw and stroke
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMaxX([[rects objectAtIndex:3] CGRectValue]),
                         CGRectGetMidY([[rects objectAtIndex:3] CGRectValue]));
    
    CGContextAddLineToPoint(context, CGRectGetMidX([[rects objectAtIndex:4] CGRectValue]),
                            CGRectGetMaxY([[rects objectAtIndex:4] CGRectValue]));
    CGContextStrokePath(context);
    
    //line five draw and stroke
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMidX([[rects objectAtIndex:4] CGRectValue]),
                         CGRectGetMinY([[rects objectAtIndex:4] CGRectValue]));
    
    CGContextAddLineToPoint(context, CGRectGetMaxX([[rects objectAtIndex:0] CGRectValue]),
                            CGRectGetMidY([[rects objectAtIndex:0] CGRectValue]));
    CGContextStrokePath(context);
}


-(void) drawElipseInRect:(CGRect)rect inContext:(CGContextRef)context andFillWithColor:(UIColor*)color{
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextFillPath(context);
}


#pragma  mark - Color -

- (UIColor*) randomColor{
    
    CGFloat r = [self randomZeroToOne];
    CGFloat g = [self randomZeroToOne];
    CGFloat b = [self randomZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}


- (CGFloat) randomZeroToOne{
    return (float)(arc4random() % 256) /255;
}


@end
