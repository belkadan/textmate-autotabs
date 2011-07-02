#import "SwizzleMacros.h"
#import "TextView.h"
#import "NSStringAdditions.h"

@interface ComBelkadanTMAutoTabs_TextView (OakTextView)
- (NSTextStorage *)textStorage;
- (id)document; // OakDocument

- (void)setSoftTabs:(BOOL)useSoftTabs;
- (void)setTabSize:(NSUInteger)tabSize;
@end


@implementation ComBelkadanTMAutoTabs_TextView
+ (void)initialize {
	if (self != [ComBelkadanTMAutoTabs_TextView class]) return;

	Class oakTextView = NSClassFromString(@"OakTextView");
	if (!oakTextView) return;

	COPY_METHOD(self, oakTextView, ComBelkadanTMAutoTabs_autodetectTabMode);
	COPY_AND_EXCHANGE(self, oakTextView, ComBelkadanTMAutoTabs_, setDocument:);
}

- (void)ComBelkadanTMAutoTabs_setDocument:(id)doc {
	[self ComBelkadanTMAutoTabs_setDocument:doc];
	if (doc) [self ComBelkadanTMAutoTabs_autodetectTabMode];
}

#pragma mark -

- (void)ComBelkadanTMAutoTabs_autodetectTabMode {
	if (![self document]) return;
	
	NSString *contents = [[self textStorage] string];
	NSUInteger tabWidth;
	if ([contents ComBelkadanTMAutoTabs_autodetectSoftTabstops:&tabWidth]) {
		if (tabWidth == NO_SOFT_TABS) {
			[self setSoftTabs:NO];
		} else {
			[self setSoftTabs:YES];
			[self setTabSize:tabWidth];
		}
	}
}

@end
