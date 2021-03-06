//
//  ViewController.h
//  Auto Complete Demo
//
//  Created by Omer Gurarslan on 18/08/14.
//  Copyright (c) 2014 Lucid Bilg. Hiz. Ltd. Şti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *aramaCubugu;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;
@property (nonatomic, retain) NSMutableArray *kisiler;
@property (nonatomic, retain) NSMutableArray *autocompleteKisileri;

@end
