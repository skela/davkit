//
//  NSDate+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 18/06/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "NSDate+DavKit.h"


#ifdef DKCalendarForiOS7
#define DKCalendarUnitSecond NSSecondCalendarUnit
#define DKCalendarUnitMinute NSMinuteCalendarUnit
#define DKCalendarUnitHour NSHourCalendarUnit
#define DKCalendarUnitDay NSDayCalendarUnit
#define DKCalendarUnitMonth NSMonthCalendarUnit
#define DKCalendarUnitYear NSYearCalendarUnit
#define DKCalendarUnitEra NSEraCalendarUnit
#else
#define DKCalendarUnitSecond NSCalendarUnitSecond
#define DKCalendarUnitMinute NSCalendarUnitMinute
#define DKCalendarUnitHour NSCalendarUnitHour
#define DKCalendarUnitDay NSCalendarUnitDay
#define DKCalendarUnitMonth NSCalendarUnitMonth
#define DKCalendarUnitYear NSCalendarUnitYear
#define DKCalendarUnitEra NSCalendarUnitEra
#endif

@implementation NSDate (DavKit)

- (BOOL)isToday
{
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:DKCalendarUnitEra|DKCalendarUnitYear|DKCalendarUnitMonth|DKCalendarUnitDay fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:DKCalendarUnitEra|DKCalendarUnitYear|DKCalendarUnitMonth|DKCalendarUnitDay fromDate:[NSDate date]];
    if([today day] == [otherDay day] && [today month] == [otherDay month] && [today year] == [otherDay year] && [today era] == [otherDay era])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isYesterday
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    NSDateComponents*comps = [[NSCalendar currentCalendar] components:DKCalendarUnitDay|DKCalendarUnitHour|DKCalendarUnitMinute|DKCalendarUnitSecond fromDate:[NSDate dateWithTimeIntervalSince1970:interval] toDate:[NSDate date] options:0];
	NSInteger val;
	val = [comps day];
	if (val==1)
        return YES;
    return NO;
}

- (BOOL)isPast
{
    return [self timeIntervalSinceNow]<0;
}

- (BOOL)isFuture
{
    return [self timeIntervalSinceNow]>0;
}

- (BOOL)isPresent
{
    return [self timeIntervalSinceNow]==0;
}

+ (NSDate*)yesterday
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-86400];
}

+ (NSDate*)ereyesterday
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-86400*2];
}

+ (NSDate*)tomorrow
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]+86400];
}

+ (NSDate*)overmorrow
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]+86400*2];
}

+ (NSDate*)lastWeek
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-604800];
}

- (NSString*)ISO8601String
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [df stringFromDate:self];
}

@end
