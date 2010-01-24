//
//  NSDate+SZRelationalOperators.h
//  Charts
//
//  Created by Jon Nall on 12/8/09.
//  Copyright 2009 Newisys. All rights reserved.
//

// Category to help make comparing NSDates a bit more readable

@interface NSDate(SZRelationalOperators)

-(BOOL)isLessThan:(NSDate*)theDate;
-(BOOL)isLessThanOrEqualTo:(NSDate*)theDate;
-(BOOL)isGreaterThan:(NSDate*)theDate;
-(BOOL)isGreaterThanOrEqualTo:(NSDate*)theDate;

@end
