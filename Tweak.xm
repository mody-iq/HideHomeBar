#import <UIKit/UIKit.h>

static BOOL HHBIsHomeIndicatorView(UIView *view) {
    NSString *className = NSStringFromClass([view class]);
    return [className rangeOfString:@"HomeIndicator" options:NSCaseInsensitiveSearch].location != NSNotFound;
}

%hook UIViewController

// Use the public UIKit API wherever it is honored by the host application.
- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeBottom;
}

%end

%hook UIView

// UIKit creates a private Home Indicator view in each relevant window. Hide it
// when it is attached and keep it hidden if UIKit tries to show it again.
- (void)didMoveToWindow {
    %orig;
    if (HHBIsHomeIndicatorView(self)) {
        [self setHidden:YES];
        [self setAlpha:0.0];
    }
}

- (void)setHidden:(BOOL)hidden {
    %orig(HHBIsHomeIndicatorView(self) ? YES : hidden);
}

- (void)setAlpha:(CGFloat)alpha {
    %orig(HHBIsHomeIndicatorView(self) ? 0.0 : alpha);
}

%end
