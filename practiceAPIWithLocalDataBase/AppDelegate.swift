//
//  AppDelegate.swift
//  practiceAPIWithLocalDataBase
//
//  Created by Lalaiya Sahil on 15/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var databasePath: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.databasePath = getDataBasePath()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func getDataBasePath() -> String{
        let documentDictoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let bundlePath = Bundle.main.path(forResource: "userFile", ofType: "db")
        print(documentDictoryPath)
        print(bundlePath)
        let dataPath = documentDictoryPath[0] + "/" + "userFile.db"
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: dataPath) == false{
            print("File copy karo")
            do{
                try fileManager.copyItem(atPath: bundlePath ?? "", toPath: dataPath)
                return dataPath
            }catch{
                print("something went wrong")
                return ""
            }
        }
        return dataPath
    }
    
}

