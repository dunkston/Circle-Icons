@interface SBIconImageView : UIView
@end

%hook SBIconImageView

	- (id)contentsImage {
		self.layer.cornerRadius = 30;
		self.layer.masksToBounds = YES;
		return %orig;
	}

%end