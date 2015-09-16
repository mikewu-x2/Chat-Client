//
//  ChatCell.m
//  Chat Client
//
//  Created by Michael Wu on 9/16/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "ChatCell.h"
#import <Parse/Parse.h>

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChat:(NSDictionary *)chat {
    
    self.chatLabel.text = chat[@"text"];
    
    if (chat[@"user"]) {
        PFUser *user = chat[@"user"];
        self.ownerLabel.text = user.username;
    } else {
        self.ownerLabel.text = @"unknown";
    }

}

@end
