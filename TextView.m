#import "SwizzleMacros.h"
#import "TextView.h"

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
	NSInteger tabsVsSpaces = 0;
	BOOL twoSpaceIndents = NO;
	NSUInteger minSpaces = 50; // FIXME

	NSScanner *scanner = [NSScanner scannerWithString:contents];
	[scanner setCharactersToBeSkipped:nil];
	
	NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
	NSCharacterSet *newline = [NSCharacterSet newlineCharacterSet];

	NSString *startOfLine;
	// For each line...
	do {
		// 1. Scan the whitespace at the beginning.
		if ([scanner scanCharactersFromSet:whitespace intoString:&startOfLine]) {
			// 2. See if it uses tabs or spaces.
			if ([startOfLine length]) {
				if ([startOfLine hasPrefix:@"\t"]) {
					// Tabs are easy.
					tabsVsSpaces += 1;
				} else if ([startOfLine hasPrefix:@"    "]) {
					// We could use two spaces as our test, but there are occasions
					// when two-space indents are distinct from tabs (Markdown).
					tabsVsSpaces -= 1;
					minSpaces = MIN(minSpaces, [startOfLine length]);
				} else if ([startOfLine hasPrefix:@"  "]) {
					// So, two spaces only counts if there are no other indents.
					twoSpaceIndents = YES;
				}
			}
		}

		// 3. Read until the end of the line.
		(void)[scanner scanUpToCharactersFromSet:newline intoString:NULL];
		// 4. Eat the newline at the end (if there is one).
	} while ([scanner scanCharactersFromSet:newline intoString:NULL]);
	
	// See how we did!
	if (tabsVsSpaces > 0) {
		[self setSoftTabs:NO];
	} else if (tabsVsSpaces < 0) {
		[self setSoftTabs:YES];
		[self setTabSize:minSpaces];
	} else if (twoSpaceIndents) {
		[self setSoftTabs:YES];
		[self setTabSize:2];
	} // else no indents; let TextMate guess about this file.
}

@end
