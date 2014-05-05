//
//  LCLTransmittingViewController.m
//  PlayingWithiBeacons
//
//  Created by Leonard Li on 5/5/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTransmittingViewController.h"

@interface LCLTransmittingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

@end

@implementation LCLTransmittingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBeacon];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B4FE5122-C434-4252-847E-AE696DF8250E"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.lenli.playingwithibeacons"];
}

- (IBAction)transmitBeacon:(UIButton *)sender {
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    [self setLabels];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    UIAlertView *alertMessage;
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        alertMessage = [[UIAlertView alloc] initWithTitle:@"Powered On" message:@"Powered On" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        alertMessage = [[UIAlertView alloc] initWithTitle:@"Powered Off" message:@"Powered Off" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.peripheralManager stopAdvertising];
    }
    [alertMessage show];
}

- (void)setLabels {
    self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.minor];
    self.identityLabel.text = self.beaconRegion.identifier;
}

@end
