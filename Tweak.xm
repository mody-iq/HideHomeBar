#import <Foundation/Foundation.h>
#import <Substrate/Substrate.h>

%hook UIWindow

- (void)setFrame:(CGRect)newFrame {
    %orig;
    
    // Hide Home Indicator by setting bottom padding to 0
    UIEdgeInsets safeAreaInsets = self.safeAreaInsets;
    if (safeAreaInsets.bottom > 0) {
        // Create a modified safe area insets without bottom padding
        UIEdgeInsets modifiedInsets = safeAreaInsets;
        modifiedInsets.bottom = 0;
        
        // Apply the modified insets
        [self setSafeAreaInsets:modifiedInsets];
    }
}

%end

%hook UIViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    // Hide Home Indicator by modifying the view's layout
    if ([self.view respondsToSelector:@selector(setSafeAreaInsets:)]) {
        UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
        if (safeAreaInsets.bottom > 0) {
            UIEdgeInsets modifiedInsets = safeAreaInsets;
            modifiedInsets.bottom = 0;
            self.view.safeAreaInsets = modifiedInsets;
        }
    }
}

- (void)viewDidLoad {
    %orig;
    
    // Additional safety check - hide home indicator for all view controllers
    if ([self.view respondsToSelector:@selector(setSafeAreaInsets:)]) {
        UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
        if (safeAreaInsets.bottom > 0) {
            UIEdgeInsets modifiedInsets = safeAreaInsets;
            modifiedInsets.bottom = 0;
            self.view.safeAreaInsets = modifiedInsets;
        }
    }
}

%end

%hook UITraitCollection

- (UIEdgeInsets)safeAreaInsets {
    UIEdgeInsets originalInsets = %orig;
    if (originalInsets.bottom > 0) {
        UIEdgeInsets modifiedInsets = originalInsets;
        modifiedInsets.bottom = 0;
        return modifiedInsets;
    }
    return originalInsets;
}

%end

%hook UIScreen

- (void)setSafeAreaInsets:(UIEdgeInsets)insets {
    UIEdgeInsets modifiedInsets = insets;
    if (modifiedInsets.bottom > 0) {
        modifiedInsets.bottom = 0;
    }
    %orig(modifiedInsets);
}

%end