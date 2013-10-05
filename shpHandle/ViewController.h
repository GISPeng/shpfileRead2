//
//  ViewController.h
//  shpHandle
//
//  Created by 智图科技 on 13-9-22.
//  Copyright (c) 2013年 智图科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface ViewController : UIViewController<AGSMapViewLayerDelegate,AGSMapViewTouchDelegate,AGSMapViewCalloutDelegate>

@property (retain, nonatomic) IBOutlet AGSMapView *mapView;
@property (retain,nonatomic) AGSGraphicsLayer *graphicsLayer;
@property (nonatomic,retain) UIPopoverController *popover;

@end
