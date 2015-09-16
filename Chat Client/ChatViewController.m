//
//  ChatViewController.m
//  Chat Client
//
//  Created by Michael Wu on 9/16/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"
#import <Parse/Parse.h>

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void) onTimer {
    // Add code to be run periodically
    //NSLog(@"timed");
    [self fetchMessages];
}

- (void) fetchMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query includeKey:@"user"];
    //[query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %lu messages.", (unsigned long)objects.count);
            // Do something with the found objects
            self.messages = objects;
            [self.tableView reloadData];
            //CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
            //[self.tableView setContentOffset:offset];
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.messages) {
        return [self.messages count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    
    NSDictionary *message = self.messages[indexPath.row];
    //cell.textLabel.text = message[@"text"];
    [cell setChat:message];
    return cell;
    
}

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [textView setText:@""];
}

- (IBAction)onSendMessage:(id)sender {
    
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.textField.text;
    message[@"user"] = [PFUser currentUser];
    
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"saved");
            self.textField.text = @"";
            [self fetchMessages];
            // The object has been saved.
        } else {
            NSLog(@"failed");
            // There was a problem, check error.description
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
