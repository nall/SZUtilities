//
//  NSDate+SZRelationalOperators.m
//  Charts
//
//  Created by Jon Nall on 12/8/09.
//  Copyright 2009 Newisys. All rights reserved.
//

#import "NSDate+SZRelationalOperators.h"


@implementation NSDate(SZRelationalOperators)

-(BOOL)isLessThan:(NSDate*)theDate
{
    return [self compare:theDate] == NSOrderedAscending;
}

-(BOOL)isLessThanOrEqualTo:(NSDate*)theDate
{
    return [self compare:theDate] != NSOrderedDescending;  
}

-(BOOL)isGreaterThan:(NSDate*)theDate
{
    return [self compare:theDate] == NSOrderedDescending;
}

-(BOOL)isGreaterThanOrEqualTo:(NSDate*)theDate
{
    return [self compare:theDate] != NSOrderedAscending;
}

@end
