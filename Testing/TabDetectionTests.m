#import <SenTestingKit/SenTestingKit.h>
#import "NSStringAdditions.h"

@interface TabDetectionTests : SenTestCase
@end


@implementation TabDetectionTests
- (void)testTrivialCases {
	NSUInteger width;
	STAssertFalse([@"" ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"no information");

	STAssertTrue([@"\t" ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"single tab");
	STAssertEquals(width, NO_SOFT_TABS, @"single tab");

	STAssertTrue([@"  " ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"two spaces");
	STAssertEquals(width, (NSUInteger)(2), @"two spaces");

	STAssertTrue([@"    " ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"four spaces");
	STAssertEquals(width, (NSUInteger)(4), @"four spaces");
}

@end

