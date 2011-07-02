#import <SenTestingKit/SenTestingKit.h>
#import "NSStringAdditions.h"

@interface TabDetectionTests : SenTestCase
@end

@interface NSString (TabDetectionTests)
- (NSUInteger)tabWidth;
@end


@implementation TabDetectionTests
- (void)testTrivialCases {
	NSUInteger width;
	STAssertFalse([@"" ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"no information");

	STAssertTrue([@"\t" ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"single tab");
	STAssertEquals(NO_SOFT_TABS, width, @"single tab");

	STAssertTrue([@"  " ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"two spaces");
	STAssertEquals((NSUInteger)(2), width, @"two spaces");

	STAssertTrue([@"    " ComBelkadanTMAutoTabs_autodetectSoftTabstops:&width], @"four spaces");
	STAssertEquals((NSUInteger)(4), width, @"four spaces");
}

@end


@implementation NSString (TabDetectionTests)
- (NSUInteger)tabWidth {
	NSUInteger tabWidth;
	NSAssert([self ComBelkadanTMAutoTabs_autodetectSoftTabstops:&tabWidth], @"This test should have been conclusive.");
	return tabWidth;
}
@end

