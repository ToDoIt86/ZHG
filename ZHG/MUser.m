//
//  MUser.m
//  ZHG
//
//  Created by lihong on 14-4-8.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "MUser.h"
#import <objc/runtime.h>

@implementation MUser
- (NSDictionary *)toDict
{
    unsigned int count = 0;
    // Get a list of all properties in the class.
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *value = [self valueForKey:key];
        // Only add to the NSDictionary if it's not nil.
        if (value)
            [dictionary setObject:value forKey:key];
    }
    free(properties);
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self setValue:obj forKey:key];
        }];
    }
    return self;
}
@end

@implementation UserLoginResponse
@end