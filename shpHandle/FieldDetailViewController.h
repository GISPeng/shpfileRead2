//
//  FieldDetailViewController.h
//  shpHandle
//
//  Created by 智图科技 on 13-9-24.
//  Copyright (c) 2013年 智图科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface FieldDetailViewController : UITableViewController

@property (nonatomic,assign) int fieldCount;
@property (nonatomic,retain) AGSGraphic *curGraphic;

-(id)initWithGraphic:(AGSGraphic *)graphic;
-(NSString *)GetKeyValueFrmDic:(int)curRow;
-(NSString *)GetKeyFrmDic:(int)curRow;
@end
