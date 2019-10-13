@interface SBIconView : UIView
@end

@interface SBFolderIconView : UIView
@end

@interface SBFolderBackgroundView : UIView
@end

static BOOL icons;
static BOOL folders;

static void loadPrefs(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:
		[NSHomeDirectory() stringByAppendingFormat:@"/Library/Preferences/%s.plist", "com.dunkston.circleicons"]];
	icons = prefs[@"icons"] ? [prefs[@"icons"] boolValue] : YES;
	folders = prefs[@"folders"] ? [prefs[@"folders"] boolValue] : YES;

	[prefs release];
}

%hook SBIconView

	- (void)layoutSubviews {
		%orig;
		if(icons) {
			self.layer.cornerRadius = self.bounds.size.width / 2;
			self.layer.masksToBounds = YES;
		}
	}

%end

%hook SBFolderIconView

	- (void)layoutSubviews {
		%orig;
		if(icons) {
			self.layer.cornerRadius = self.bounds.size.width / 2;
			self.layer.masksToBounds = YES;
		}
	}

%end

%hook SBFolderBackgroundView

	- (void)layoutSubviews {
		%orig;
		if(folders) {
			self.layer.cornerRadius = self.bounds.size.width / 2;
			self.layer.masksToBounds = YES;
		}
	}

%end

%ctor {
	loadPrefs(nil, nil, nil, nil, nil);

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback)loadPrefs,
		CFSTR("com.dunkston.circleicons.preferencesChanged"),
		NULL,
		CFNotificationSuspensionBehaviorDeliverImmediately
	);
}