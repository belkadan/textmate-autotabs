#import "SwizzleMacros.h"
#import "TextView.h"

#import <Cocoa/Cocoa.h>

@interface ComBelkadanTMAutoTabs_PlugIn : NSObject
@end

@interface NSWindowController (ComBelkadanTMAutoTabs_PlugIn)
// Actually -(OakTextView *)textView;
// NOT -(NSTextView *)textView; !
- (ComBelkadanTMAutoTabs_TextView *)textView;
@end


@implementation ComBelkadanTMAutoTabs_PlugIn
- (id)initWithPlugInController:(id /*<TMPlugInController> */)aController {
	if ((self = [super init])) {

		// Inject into OakTextView
		(void)[ComBelkadanTMAutoTabs_TextView class]; // force +initialize
			
		// Autodetect any existing windows.
		for (NSWindow *window in [NSApp windows]) {
			NSWindowController *controller = [window windowController];
			if ([controller respondsToSelector:@selector(textView)]) {
				ComBelkadanTMAutoTabs_TextView *textView = [controller textView];
				if ([textView respondsToSelector:@selector(ComBelkadanTMAutoTabs_autodetectTabMode)]) {
					[textView ComBelkadanTMAutoTabs_autodetectTabMode];					
				}
			}
		}
		
		// No need to keep the plugin instance around after the injection is done.
		[self release]; self = nil;
	}
	return self;
}

@end
