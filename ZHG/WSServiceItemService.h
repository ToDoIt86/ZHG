//
//  WSFood.h
//  ZHG
//
//  Created by lihong on 14-5-1.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface WSServiceItemService : NSObject

//推荐商品
+ (void)indexTopis:(NSInteger)count
       onCompleted:(JSONModelObjectBlock)block;

+ (void)getItemByCId:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block;

+ (void)getItemByKey:(NSString *)keyWord
            pageSize:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block;

+ (void)getItem:(NSString *)itemsn
    onCompleted:(JSONModelObjectBlock)block;

+ (void)getItemBasicProperty:(NSString *)itemsn
                      usersn:(NSString *)usersn
                     groupsn:(NSString *)groupsn
                 onCompleted:(JSONModelObjectBlock)block;

+(void)getItemContents:(NSString *)itemsn
           onCompleted:(JSONModelObjectBlock)block;

+ (void)getItemProperties:(NSString *)itemsn
              onCompleted:(JSONModelObjectBlock)block;

+ (void)getClassItem:(NSString *)order
            pageSize:(NSUInteger)pageSize
           pageIndex:(NSUInteger)pageIndex
         onCompleted:(JSONModelObjectBlock)block;

+ (void)addCollection:(NSString *)itemsn
          onCompleted:(JSONModelObjectBlock)block;

+ (void)addShare:(NSString *)itemsn
     onCompleted:(JSONModelObjectBlock)block;

+ (void)getRecommend:(NSString *)groupsn
             classId:(NSString *)classID
         onCompleted:(JSONModelObjectBlock)block;

+ (void)getActivities_info:(NSString *)groupsn
               onCompleted:(JSONModelObjectBlock)block;
@end
