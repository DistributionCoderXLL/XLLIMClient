//
//  XLLTextView.m
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/16.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLTextView.h"
#import "NSString+XLLLimit.h"
#import "NSString+XLLLimit.h"
#import <objc/runtime.h>

@interface XLLViewTempDelegate : NSObject <UITextViewDelegate>

@property (nonatomic, weak) id myDelegate;
@property (nonatomic, weak) id customDelegate;
@property (nonatomic, strong) Protocol *protocol;

@end

@implementation XLLViewTempDelegate

#pragma mark - lazy loading
- (Protocol *)protocol
{
    if (_protocol == nil)
    {
        _protocol = objc_getProtocol("UITextViewDelegate");
    }
    return _protocol;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    struct objc_method_description des = protocol_getMethodDescription(self.protocol, aSelector, NO, YES);
    if (des.types == NULL) {
        return [super respondsToSelector:aSelector];
    }
    if ([self.myDelegate respondsToSelector:aSelector] || [self.customDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

//生成消息传递签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *mySign = [self.myDelegate methodSignatureForSelector:aSelector];
    NSMethodSignature *customSign = [self.customDelegate methodSignatureForSelector:aSelector];
    return mySign?:customSign?:nil;
}

//消息传递target
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = anInvocation.selector;
    BOOL isResponse = NO;
    if ([self.myDelegate respondsToSelector:sel])
    {
        isResponse = YES;
        [anInvocation invokeWithTarget:self.myDelegate];
    }
    if ([self.customDelegate respondsToSelector:sel])
    {
        isResponse = YES;
        [anInvocation invokeWithTarget:self.customDelegate];
    }
    if (!isResponse)
    {
        [anInvocation doesNotRecognizeSelector:sel];
    }
}

@end

@interface XLLTextView ()

@property (nonatomic, strong) XLLViewTempDelegate *tempDelegate;
@property (nonatomic, copy) NSString *viewText;

@end

@implementation XLLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    XLLViewTempDelegate *tempDelegate = [[XLLViewTempDelegate alloc] init];
    tempDelegate.myDelegate = self;
    tempDelegate.customDelegate = delegate;
    [super setDelegate:tempDelegate];
    self.tempDelegate = tempDelegate;
}

- (void)drawRect:(CGRect)rect
{
    self.font = [UIFont systemFontOfSize:self.textConfig.fontSize];
    if (!self.hasText)
    {
        // 将占位文字画到textView上
        [self.textConfig.placeholder drawInRect:CGRectMake(self.textConfig.leftMargin, 10, rect.size.width - 2 * self.textConfig.leftMargin, 20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textConfig.fontSize], NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    UITextRange *markRange = textView.markedTextRange;
    UITextPosition *pos = [textView positionFromPosition:markRange.start offset:0];
    if (markRange && pos)
    {
        return YES;
    }
    if ([self currentCharCount:textView.text] + [self currentCharCount:text] > self.textConfig.maxLimitCount)
    {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *markRange = textView.markedTextRange;
    UITextPosition *pos = [textView positionFromPosition:markRange.start offset:0];
    if (markRange && pos) {
        [self setNeedsDisplay];
        return;
    }
    if ([self currentCharCount:textView.text] > self.textConfig.maxLimitCount)
    {
        NSRange selectedRange = textView.selectedRange;
        NSString *tmpSTR = textView.text;
        textView.text = self.viewText;
        selectedRange.location -= (tmpSTR.length - self.viewText.length);
        [self setSelectedRange:selectedRange];
    } else {
        self.viewText = textView.text;
        [self setNeedsDisplay];
    }
}

- (NSInteger)currentCharCount:(NSString *)string
{
    switch (self.textConfig.charStyle) {
        case XLLTextFieldCharStyleNormal:
            return string.length;
        case XLLTextFieldCharStyleDouble:
            return [string xllDoubleLength];
        case XLLTextFieldCharStyleHalf:
            return [string xllHalfLength];
        default:
            break;
    }
}


@end
