//
//  LCLTransmittingViewController.h
//  PlayingWithiBeacons
//
//  Created by Leonard Li on 5/5/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface LCLTransmittingViewController : UIViewController <CBPeripheralManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
