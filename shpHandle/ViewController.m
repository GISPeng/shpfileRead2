//
//  ViewController.m
//  shpHandle
//
//  Created by 智图科技 on 13-9-22.
//  Copyright (c) 2013年 智图科技. All rights reserved.
//

#import "ViewController.h"
#import "FieldDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize popover = _popover;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.layerDelegate = self;
	self.mapView.touchDelegate = self;
    self.mapView.calloutDelegate = self;
    NSURL *mapUrl = [NSURL URLWithString:@"http://server.arcgisonline.com/ArcGIS/rest/services/ESRI_StreetMap_World_2D/MapServer"];
	AGSTiledMapServiceLayer *tiledLyr = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl];
	[self.mapView addMapLayer:tiledLyr withName:@"Tiled Layer"];
	self.graphicsLayer = [AGSGraphicsLayer graphicsLayer];
    
	// 简单渲染
//	AGSCompositeSymbol* composite = [AGSCompositeSymbol compositeSymbol];
//	AGSSimpleMarkerSymbol* markerSymbol = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
//	markerSymbol.style = AGSSimpleMarkerSymbolStyleSquare;
//	markerSymbol.color = [UIColor greenColor];
//	[composite.symbols addObject:markerSymbol];
//	AGSSimpleLineSymbol* lineSymbol = [[[AGSSimpleLineSymbol alloc] init] autorelease];
//	lineSymbol.color= [UIColor redColor];
//	lineSymbol.width = 10;
//	[composite.symbols addObject:lineSymbol];
//	AGSSimpleFillSymbol* fillSymbol = [[[AGSSimpleFillSymbol alloc] init] autorelease];
//	fillSymbol.color = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.5] ;
//	[composite.symbols addObject:fillSymbol];
//    AGSSimpleRenderer* renderer = [AGSSimpleRenderer simpleRendererWithSymbol:composite];
    
    
    // 唯一值渲染
//    AGSSimpleMarkerSymbol* markerSymbol = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
//	markerSymbol.style = AGSSimpleMarkerSymbolStyleSquare;
//	markerSymbol.color = [UIColor greenColor];
//    
//    AGSSimpleMarkerSymbol* Symbol2 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
//	Symbol2.style = AGSSimpleMarkerSymbolStyleCircle;
//	Symbol2.color = [UIColor redColor];
//    
//    AGSSimpleMarkerSymbol* Symbol3 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
//	Symbol3.style = AGSSimpleMarkerSymbolStyleDiamond;
//	Symbol3.color = [UIColor blueColor];
//    
//    AGSSimpleMarkerSymbol* Symbol4 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
//	Symbol4.style = AGSSimpleMarkerSymbolStyleX;
//	Symbol4.color = [UIColor yellowColor];
//    
//    AGSUniqueValueRenderer *poiRenderer = [[[AGSUniqueValueRenderer alloc] init] autorelease];
//    //默认符号、对比字段
//    poiRenderer.defaultSymbol = markerSymbol;
//    poiRenderer.field1 = @"TYPE";
//    //设定唯一值
//    AGSUniqueValue* sym2 = [[AGSUniqueValue alloc] initWithValue:@"2" label:@"2" description:nil symbol:Symbol2];
//    AGSUniqueValue* sym3 = [[AGSUniqueValue alloc] initWithValue:@"3" label:@"3" description:nil symbol:Symbol3];
//    AGSUniqueValue* sym4 = [[AGSUniqueValue alloc] initWithValue:@"4" label:@"4 " description:nil symbol:Symbol4];
//    
//    [poiRenderer.uniqueValues addObject: sym2];
//    [poiRenderer.uniqueValues addObject: sym3];
//    [poiRenderer.uniqueValues addObject: sym4];
    
    // 分级渲染
    AGSClassBreaksRenderer *rainRenderer =[[[AGSClassBreaksRenderer alloc] init] autorelease];
    rainRenderer.field = @"TYPE";
    AGSSimpleMarkerSymbol* Symbol2 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
	Symbol2.style = AGSSimpleMarkerSymbolStyleCircle;
	Symbol2.color = [UIColor redColor];
    Symbol2.size = 20;
    
    AGSSimpleMarkerSymbol* Symbol3 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
	Symbol3.style = AGSSimpleMarkerSymbolStyleCircle;
	Symbol3.color = [UIColor blueColor];
    Symbol3.size = 30;
    
    AGSSimpleMarkerSymbol* Symbol4 = [[[AGSSimpleMarkerSymbol alloc] init] autorelease];
	Symbol4.style = AGSSimpleMarkerSymbolStyleCircle;
	Symbol4.color = [UIColor yellowColor];
    Symbol4.size = 40;
    //分级段
    AGSClassBreak* lowClassBreak = [AGSClassBreak classBreakInfoWithLabel:@"LowClass" description:@"" maxValue:2 symbol:Symbol2];
    AGSClassBreak* mediumClassBreak =[AGSClassBreak classBreakInfoWithLabel:@"MediumClass" description:@"" maxValue:4 symbol:Symbol3];
    AGSClassBreak* highClassBreak = [AGSClassBreak classBreakInfoWithLabel:@"HighClass" description:@"" maxValue:6 symbol:Symbol4];
    //添加到分级数组
    NSMutableArray* classBreaks = [NSMutableArray array];
    [classBreaks addObject:lowClassBreak];
    [classBreaks addObject:mediumClassBreak];
    [classBreaks addObject:highClassBreak];
    rainRenderer.classBreaks = classBreaks;
    
	_graphicsLayer.renderer = rainRenderer;
	[self.mapView addMapLayer:self.graphicsLayer withName:@"graphicsLayer"];
}

- (void)mapViewDidLoad:(AGSMapView *)mapView
{
    NSString *mainPath =[[NSBundle mainBundle] resourcePath];
    //NSString *shpPath = [NSString stringWithFormat:@"%@/res4_4m",mainPath];  // Original path
    NSString *shpPath = [NSString stringWithFormat:@"%@/",mainPath];
    NSMutableArray * data = shp2AGSGraphics(shpPath ,@"XianCh_Pt");  // Point
    //NSMutableArray * data = shp2AGSGraphics(shpPath ,@"bou1_4l");  // Line
    //NSMutableArray * data = shp2AGSGraphics(shpPath ,@"bou1_4p");  // Polygon
    
    // Add each graphic to graphicsLayer
    AGSGraphic *curGraphic = [[AGSGraphic alloc] autorelease];
    for (int i = 0; i < data.count; i++)
    {
        curGraphic = (AGSGraphic *)[data objectAtIndex:i];
        if (curGraphic == nil) {
            continue;
        }
        [self.graphicsLayer addGraphic:curGraphic];
    }
    [self.graphicsLayer dataChanged];
}

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics
{
    // 去掉上一次弹出的popover
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
    
    NSArray *graphicArray = [graphics objectForKey:@"graphicsLayer"];
    if ([graphicArray count] > 0)
    {
        AGSGraphic *curGraphic = [[AGSGraphic alloc] autorelease];
        curGraphic = [graphicArray objectAtIndex:0];
        self.mapView.callout.customView = nil;
        self.mapView.callout.title = (NSString *)[curGraphic.attributes objectForKey:@"PYNAME"];
        self.mapView.callout.detail = nil;
        self.mapView.callout.accessoryButtonHidden=NO;
        //self.mapView.callout.image=[UIImage imageNamed:@"ArcGIS.bundle/esri.png"];
        self.mapView.callout.autoAdjustWidth=YES;
        [self.mapView showCalloutAtPoint:(AGSPoint *)mappoint forGraphic:curGraphic animated:YES];
    }
}

- (void)mapView:(AGSMapView *)mapView didClickCalloutAccessoryButtonForGraphic:(AGSGraphic *)graphic
{
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
    //the controller we want to present as a popover
    FieldDetailViewController *controller = [[[FieldDetailViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [controller initWithGraphic:graphic];
    controller.title = nil;
    self.popover = [[[UIPopoverController alloc] initWithContentViewController:controller] autorelease];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.popover.popoverContentSize = CGSizeMake(300, 400);
    }

    //sender is the UIButton view
    CGRect rect = CGRectMake(self.mapView.callout.bounds.origin.x,self.mapView.callout.bounds.origin.y,
                              self.mapView.callout.bounds.size.width, self.mapView.callout.bounds.size.height/2);
    [self.popover presentPopoverFromRect:rect inView:self.mapView.callout permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mapView release];
    [super dealloc];
}
@end
