@interface SBIconImageView : UIView
@end

@interface SBFolderIconImageView : UIView
@end

@interface SBFolderBackgroundView : UIView
@end

static NSInteger iconSize = 0;
static NSInteger folderSize = 0;

%hook SBIconImageView

	- (void)layoutSubviews {
		%orig;
		if(iconSize == 0) iconSize = self.frame.size.width;
		self.layer.cornerRadius = iconSize / 2;
		self.layer.masksToBounds = YES;
	}

%end

%hook SBFolderIconImageView

	- (void)layoutSubviews {
		%orig;
		self.layer.cornerRadius = iconSize / 2;
		self.layer.masksToBounds = YES;
	}

%end

%hook SBFolderBackgroundView

	- (void)layoutSubviews {
		%orig;
		if(folderSize == 0) folderSize = self.frame.size.width;
		self.frame = CGRectMake(0, 0, folderSize, folderSize);
		self.layer.cornerRadius = folderSize / 2;
		self.layer.masksToBounds = YES;
	}

%end