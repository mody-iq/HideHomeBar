ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
THEOS_PACKAGE_SCHEME = roothide

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = hidehomebar

hidehomebar_FILES = Tweak.xm
hidehomebar_CFLAGS = -fobjc-arc
hidehomebar_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
