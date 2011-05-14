//
//  Ohm_s_LawAppDelegate.h
//  Ohm's Law
//
//  Created by Robert Diamond on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ohm_s_LawViewController;

@interface Ohm_s_LawAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Ohm_s_LawViewController *viewController;

@end
