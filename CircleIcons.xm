@interface SBIconImageView : UIView
@end

@interface SBFolderIconImageView : UIView
@end

@interface SBFolderBackgroundView : UIView
@end

static BOOL icons;
static BOOL folders;

static CGFloat iconSize = 0;
static CGFloat folderSize = 0;

static void loadPrefs(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:
		[NSHomeDirectory() stringByAppendingFormat:@"/Library/Preferences/%s.plist", "com.dunkston.circleicons"]];
	
	icons = prefs[@"icons"] ? [prefs[@"icons"] boolValue] : YES;
	folders = prefs[@"folders"] ? [prefs[@"folders"] boolValue] : YES;

	[prefs release];
}

%hook SBIconImageView

	- (void)layoutSubviews {
		%orig;
		if(iconSize == 0) iconSize = self.frame.size.width;
		if(icons) {
			self.layer.cornerRadius = iconSize / 2;
			self.layer.masksToBounds = YES;
		}
	}

%end

%hook SBFolderIconImageView

	- (void)layoutSubviews {
		%orig;
		if(icons) {
			self.layer.cornerRadius = iconSize / 2;
			self.layer.masksToBounds = YES;
		}
	}

%end

%hook SBFolderBackgroundView

	- (void)layoutSubviews {
		%orig;
		if(folderSize == 0) folderSize = self.frame.size.width;
		if(folders) {
			self.frame = CGRectMake(0, 0, folderSize, folderSize);
			self.layer.cornerRadius = folderSize / 2;
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