#import "NSStringAdditions.h"


@implementation NSString (ComBelkadanTMAutoTabs)
- (BOOL)ComBelkadanTMAutoTabs_autodetectSoftTabstops:(NSUInteger *)width {
	NSAssert(width != NULL, @"Must have an out parameter!");
	
	NSInteger tabsVsSpaces = 0;
	BOOL twoSpaceIndents = NO;
	NSUInteger minSpaces = 50; // FIXME
	
	NSScanner *scanner = [NSScanner scannerWithString:self];
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
		*width = 0;
	} else if (tabsVsSpaces < 0) {
		*width = minSpaces;
	} else if (twoSpaceIndents) {
		*width = 2;
	} else {
		return NO;
	}
	
	return YES;
}
@end
