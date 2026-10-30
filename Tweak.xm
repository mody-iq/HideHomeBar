#import <UIKit/UIKit.h>

// Request that every view controller hide the Home Indicator when supported.
// These APIs were introduced in iOS 11 and are safe to override system-wide.
%hook UIViewController

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeBottom;
}

%end
