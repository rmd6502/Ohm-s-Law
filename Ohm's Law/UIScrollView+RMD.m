//
//  UIScrollView+RMD.m
//  Ohm's Law
//
//  Created by Robert Diamond on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+RMD.h"

@implementation UIScrollView (RMD)

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!self.dragging && !self.tracking) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
}

@end
