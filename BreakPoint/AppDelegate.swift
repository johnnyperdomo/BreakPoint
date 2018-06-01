//
//  AppDelegate.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        if GIDSignIn.sharedInstance().hasAuthInKeychain() == false && Auth.auth().currentUser == nil { //if there is no user logged in, present AuthVC
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) //constant to hold the storyboard
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC")
            window?.makeKeyAndVisible() //make it key window
            window?.rootViewController?.present(authVC, animated: true, completion: nil) //call a viewController on top of the rootView controller(or the view controller we are currently on.) So it doesn't matter what screen youre on, if logged out...authVC will present.
            
        }
        
        
        return true
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google: ", err)
            return
        }
        
        print("Successfully logged into Google", user)
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        

        Auth.auth().signIn(with: credential) { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google Account: ", err)
            }
            
            let userData = ["provider": user?.providerID, "email": user?.email] //dictionary of user data
            DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData)
            
            print("Successfully logged into Firebase with Google", user?.uid)
            
            if !(GIDSignIn.sharedInstance().hasAuthInKeychain()) { //if no user was created
                AuthService.instance.loginUser(withEmail: (user?.email)!, andPassword: authentication.accessToken, loginComplete: { (success, loginError) in
                    if success {
                        print("login successfully to app")
                    } else {
                        print("damn")
                        print(String(describing: loginError?.localizedDescription))
                    }
                })
            }
            
        }
    }
    
    func signOutOfGoogle() { //sign out
        let firebaseAuth = Auth.auth()
        
        do {
            GIDSignIn.sharedInstance().disconnect() //Disconnects the current user from the app and revokes previous authentication.
            try firebaseAuth.signOut() //sign out
            print("Successfully logged out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

