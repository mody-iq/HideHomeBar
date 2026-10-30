TARGET := iphone:clang:latest:7.0
@@KILL_RULE@@

include @@THEOS@@/makefiles/common.mk

TWEAK_NAME = hidehomebar

hidehomebar_FILES = Tweak.xm
hidehomebar_CFLAGS = -fobjc-arc -Wno-error=unused-variable -Wno-error=shadow-declaration -Wno-error=conditional-uninitialized

include $(THEOS_MAKE_PATH)/tweak.mk