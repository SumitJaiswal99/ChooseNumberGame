//
//  UserManager.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import Foundation
import CoreData

class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    func createUser(userName: String, password: String) -> (errorCode: Int, errorMessage: String) {
        
        
        let checkUserExistResult = checkUserExist(userName: userName, password: password)
        
        if checkUserExistResult.errorCode == 200 {
            let user = User(context: CoreDataManager.shared.context)
            let userCount = userStandard.integer(forKey: UserDefaultKey.registerUserCount.rawValue) + 1
            user.userId = "\(userCount)"
            user.userName = userName
            
            user.password = password
            
            userStandard.set(userCount, forKey: UserDefaultKey.registerUserCount.rawValue)
            CoreDataManager.shared.saveContext()
            return (errorCode: checkUserExistResult.errorCode, errorMessage: checkUserExistResult.errorMessage)
        }
        return (errorCode: checkUserExistResult.errorCode, errorMessage: checkUserExistResult.errorMessage)
    }
    
    //MARK: Most of time available on server side.
    private func checkUserExist(userName: String, password: String) -> (errorCode: Int, errorMessage: String) {
        
        
        let fetchRequest = NSFetchRequest<User>(entityName: User.description())
        //        let predicate = NSPredicate(format: "emailId==%@", emailId as CVarArg)
        //        let predicate = NSPredicate(format: "contactNumber==%@", contactNumber as CVarArg)
        //TODO: Complex Predicate
        let userPredicate = NSPredicate(format: "userName==%@", userName as CVarArg)
//        let passwordPredicate = NSPredicate(format: "password==%@", password as CVarArg)
//        let andPredicate = NSCompoundPredicate(type: .or, subpredicates: [userPredicate, passwordPredicate])
        let andPredicate = NSCompoundPredicate(type: .or, subpredicates: [userPredicate])
        fetchRequest.predicate = andPredicate
        
        do {
            if let users = try CoreDataManager.shared.context.fetch(fetchRequest) as? [User] {
                if users.count == 1 {
                    
                    if users.first!.userName == userName {
                        return (errorCode: 201, errorMessage: "userName already register")
                        
                    }
//                    else if users.first!.password == password {
//                        return (errorCode: 201, errorMessage: "password already register")
//                    }
                }
                return (errorCode: 200, errorMessage: "User successfully create")
            }
        }
        catch {
            print("Error occured during fetch students: \(error)")
        }
        return (errorCode: 200, errorMessage: "User successfully create")
    }
    
    func checkUserAbleToLogin(userName: String, password: String) -> (errorCode: Int, errorMessage: String, userDetails: User?) {
        
        let fetchRequest = NSFetchRequest<User>(entityName: User.description())
        let predicate = NSPredicate(format: "userName==%@", userName as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            if let users = try CoreDataManager.shared.context.fetch(fetchRequest) as? [User] {
                if users.count == 1 {
                    if users.first!.password == password {
                        
                        return (errorCode: 200, errorMessage: "Success", userDetails: users.first)
                    }
                    else {
                        return (errorCode: 201, errorMessage: "Invalid Password!", userDetails: nil)
                    }
                }
                return (errorCode: 201, errorMessage: "User not exist", userDetails: nil)
            }
        }
        catch {
            print("Error occured during fetch students: \(error)")
        }
        return (errorCode: 201, errorMessage: "User not exist", userDetails: nil)
    }
    
}
