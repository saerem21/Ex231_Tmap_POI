//
//  ViewController.m
//  Ex231_Tmap_POI
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#define TOOLBAR_HIGHT 60
#define APP_KEY @"230febe2-ce30-303c-a8d1-827c4104161b"
@interface ViewController ()<UISearchBarDelegate,TMapViewDelegate>

@property (strong,nonatomic)TMapView *mapView;

@end

@implementation ViewController

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [_mapView clearCustomObjects];
    
    NSString *keyword = searchBar.text;
    TMapPathData *path = [[TMapPathData alloc] init];
    NSArray *result = [path requestFindAddressPOI:keyword];
    NSLog(@"number of poi %d",result.count);
    int i =0;
    for(TMapPOIItem *item in result){
        NSLog(@"number %@ %@",[item getPOIName],[item getPOIPoint]);
        NSString *markerID = [NSString stringWithFormat:@"marker %d",i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc] init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"ball1.png"]];
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [_mapView addCustomObject:marker ID:markerID];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, 320, 300);
    _mapView = [[TMapView alloc] initWithFrame:rect];
    [_mapView setSKPMapApiKey:APP_KEY];
    _mapView.zoomLevel = 12.0;
    _mapView.delegate =self;
    [self.view addSubview:_mapView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
