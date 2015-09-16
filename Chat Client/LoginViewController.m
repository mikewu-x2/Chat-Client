//
//  LoginViewController.m
//  Chat Client
//
//  Created by Michael Wu on 9/16/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSignUpAction:(id)sender {
    NSLog(@"Sign up");
    [self signUpPFUser];
}
- (IBAction)onSignInAction:(id)sender {
    NSLog(@"Sign in");
    [self signInPFUser];
}

- (void)generateError:(NSString *)error {
    
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 50)];
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    errorView.backgroundColor = [UIColor redColor];
    errorView.alpha = 0.8;
    errorView.tag = 99;
    
    errorLabel.text = [[NSString alloc] initWithFormat:@"%@", error];
    errorLabel.font = [UIFont boldSystemFontOfSize:16];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.textColor = [UIColor whiteColor];
    [errorView addSubview:errorLabel];
    
    [self.view addSubview:errorView];
    
}

- (void) signUpPFUser {
    
    NSString *name = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    PFUser *user = [PFUser user];
    user.username = self.emailTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            NSLog(@"Sign up success");
        } else {
            NSLog(@"Sign up fail, %@, %@", name, password);
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            [self generateError:errorString];
        }
    }];
    
}

- (void) signInPFUser {
    
    NSString *name = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:name password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Sign in success");
                                            
                                            //ChatViewController *chatViewController = [[ChatViewController alloc] init];
                                            [self performSegueWithIdentifier:@"com.yahoo.pushintochat" sender:self];
                                            //[self presentModalViewController:chatViewController animated:YES];
                                            //[self.navigationController pushViewController:chatViewController animated:YES];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"Sign in fail, %@, %@", name, password);
                                            [self generateError:@"Login failure"];
                                        }
                                    }];
    
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
