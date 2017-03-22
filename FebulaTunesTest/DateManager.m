//
//  DateManager.m
//  FebulaTunesTest
//
//  Created by Paul on 22.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateManager.h"

@implementation DateManager

- (NSString *) currentDate {
  NSDateFormatter *formatter;
  NSString        *dateString;
  formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"d MMMM"];
  NSLocale *locale = [[NSLocale alloc]
                      initWithLocaleIdentifier:@"ru_RU"];
  [formatter setLocale:locale];
  dateString = [formatter stringFromDate:[NSDate date]];
  return dateString;
}

@end
