//
//  FieldDetailViewController.m
//  shpHandle
//
//  Created by 智图科技 on 13-9-24.
//  Copyright (c) 2013年 智图科技. All rights reserved.
//

#import "FieldDetailViewController.h"
#import "FieldDetailCell.h"

@interface FieldDetailViewController ()

@end

@implementation FieldDetailViewController

@synthesize fieldCount = _fieldCount;
@synthesize curGraphic = _curGraphic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark init method
-(id)initWithGraphic:(AGSGraphic *)graphic
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _curGraphic = graphic;
        _fieldCount = [[graphic attributes] count];
    }
    return self;
}


#pragma Helper
- (NSString *)GetKeyValueFrmDic:(int)curRow
{
    int i = 0;
    NSString *resStr = @"";
    for (id key in _curGraphic.attributes) {
        if (curRow == i) {
            id detail = [[_curGraphic attributes] objectForKey:key];
            if ([[[detail class] description] isEqualToString:@"__NSCFNumber"]) {
                resStr = [NSString stringWithFormat:@"%d",detail];
            }
            else
            {
                resStr = detail;
            }
        }
        i++;
    }
    return resStr;
}

- (NSString *)GetKeyFrmDic:(int)curRow
{
    NSString *resStr = @"";
    int i = 0;
    for (id key in _curGraphic.attributes) {
        if (i == curRow) {
            resStr = key;
        }
        i++;
    }
    return resStr;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _fieldCount;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Feature Details";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    static NSString *_customIdentifier = @"FieldDetailCell";
    FieldDetailCell *cell=(FieldDetailCell *)[tableView dequeueReusableCellWithIdentifier:_customIdentifier];
    
    if (cell==nil) {
        NSArray *_nib=[[NSBundle mainBundle] loadNibNamed:@"FieldDetail"
                                                    owner:self
                                                  options:nil];
        cell = (FieldDetailCell *)[_nib objectAtIndex:0];
        cell.textLabel.text = [self GetKeyFrmDic:indexPath.row];
        cell.detailTextLabel.text = [self GetKeyValueFrmDic:indexPath.row];
    }
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_curGraphic release];
    _curGraphic = nil;
    [super dealloc];
}

@end
