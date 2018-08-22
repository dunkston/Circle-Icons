include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CircleIconsPreferences
CircleIconsPreferences_FILES = CircleIconsPreferencesController.m
CircleIconsPreferences_INSTALL_PATH = /Library/PreferenceBundles
CircleIconsPreferences_FRAMEWORKS = UIKit
CircleIconsPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CircleIconsPreferences.plist$(ECHO_END)