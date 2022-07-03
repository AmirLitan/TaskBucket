
//This struct for futuer tasting
import Foundation

struct UserData {
    
    mutating func createUsers() -> [String: User]?{
        let user1 = User("AAA","123","a@g.com","group1")
        let user2 = User("BBB","456","b@g.com","group1")
        
        let users: [String: User] = [user1.id!: user1,user2.id!: user2]
        return users
    }
}
