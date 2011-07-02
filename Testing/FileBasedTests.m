#import <SenTestingKit/SenTestingKit.h>

#import "NSStringAdditions.h"

@interface FileBasedTestSuite : SenTestSuite
- (id)initWithName:(NSString *)name testURLs:(NSArray *)testURLs;
@end

@interface FileBasedTest : SenTestCase {
	NSURL *url;
}
- (void)test;
@end


@implementation FileBasedTestSuite
- (id)initWithName:(NSString *)name testURLs:(NSArray *)testURLs {
	self = [super initWithName:name];
	if (!self) return nil;
	
	for (NSURL *url in testURLs) {		
		SenTestCase *test = [[FileBasedTest alloc] initWithURL:url];
		[self addTest:test];
		[test release];
	}
	
	return self;
}
@end

@implementation FileBasedTest

+ (SenTestSuite *)defaultTestSuite {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSArray *testURLs = [bundle URLsForResourcesWithExtension:nil subdirectory:@"FileTests"];
	return [[[FileBasedTestSuite alloc] initWithName:@"FileBasedTests" testURLs:testURLs] autorelease];
}

- (id)initWithURL:(NSURL *)givenURL {
	self = [super initWithSelector:@selector(test)];
	if (!self) return nil;
	
	url = [givenURL copy];
	
	return self;
}

- (void)dealloc {
	[url release];
	[super dealloc];
}

- (NSString *)name {
	return [NSString stringWithFormat:@"%@ (file-based)", [url lastPathComponent]];
}

- (void)test {
	STAssertNotNil(url, @"invalid url: %@", url);

	NSString *basename = [url lastPathComponent];
	STAssertNotNil(basename, @"invalid url: %@", url);
	STAssertFalse([@"" isEqual:basename], @"invalid url: %@", url);
	
	unichar firstChar = [basename characterAtIndex:0];
	STAssertTrue([[NSCharacterSet alphanumericCharacterSet] characterIsMember:firstChar], @"invalid test name: %@", basename);
	BOOL shouldBeConclusive = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:firstChar];
	
	NSError *error = nil;
	NSString *contents = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
	STAssertNotNil(contents, @"unable to load file '%@': %@", basename, error);
	
	if (shouldBeConclusive) {
		NSUInteger expected = (NSUInteger)[basename integerValue];
		
		NSUInteger actual = (~0);
		STAssertTrue([contents ComBelkadanTMAutoTabs_autodetectSoftTabstops:&actual], @"this test should have been conclusive: %@", basename);
		STAssertEquals(actual, expected, @"incorrect guess for '%@'", basename);

	} else {
		NSUInteger detected = (~0);
		BOOL wasConclusive = [contents ComBelkadanTMAutoTabs_autodetectSoftTabstops:&detected];
		if (wasConclusive) {
			if (detected == NO_SOFT_TABS) {
				STFail(@"'%@' should not have been conclusive, but tabs were detected", basename);
			} else {
				STFail(@"'%@' should not have been conclusive, but %lu spaces were detected", (unsigned long) detected);
			}
		}
	}
}

@end
