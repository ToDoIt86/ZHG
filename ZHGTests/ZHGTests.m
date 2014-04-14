//
//  ZHGTests.m
//  ZHGTests
//
//  Created by lihong on 14-4-3.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WSUser.h"

@interface ZHGTests : XCTestCase

@end

@implementation ZHGTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserService
{
    NSLog(@"%s",__FUNCTION__);
    [WSUser registerWithUserName:@"FuckSBServerProgramer" andPassword:@"fuckyou" onCompleted:^(id m,NSError *err){
        MWSResponse *response = (MWSResponse *)m;
        NSLog(@"%@ %@",response.success?@"注册成功":@"注册失败",response.message);
    }];
    
    [WSUser loginWithUserName:@"FuckSBServerProgramer" andPassword:@"fuckyou" onCompleted:^(id jsonString, JSONModelError *err) {
        
    }];
    
    [WSUser userInfoWithUserName:@"FuckSBServerProgramer" andPassword:@"fuckyou" onCompleted:^(id jsonString, JSONModelError *err) {
        
    }];
    
    while(1);
}

@end
