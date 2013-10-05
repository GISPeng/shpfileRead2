//
//  Cluster.m
//  TestShp
//
//  Created by baocai zhang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Cluster.h"

@implementation Cluster
@synthesize cx=_cx;
@synthesize cy=_cy;
@synthesize n=_n;

// 对象创建分两步：alloc和init
// 编写新的子类时，总是要编写新的init方法，并在此方法中初始化新子类特有的变量
// init通常不带参数，但也可以指定参数，如[[UITextView alloc] initWithFrame:CGRect(,,,)]
- (id) initWithX:(double)x y:(double)y cx:(double)cx cy:(double)cy spatialReference:(AGSSpatialReference *)spatialReference
{
    if (self =[super initWithX:x y:y spatialReference:spatialReference]) {
        _cx = cx;
        _cy = cy;
        _n =1;
    }
    return  self;
}
@end
