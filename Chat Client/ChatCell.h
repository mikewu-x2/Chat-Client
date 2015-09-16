//
//  ChatCell.h
//  Chat Client
//
//  Created by Michael Wu on 9/16/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
- (void) setChat:(NSDictionary *) chat;
@end
