import Foundation
class User {
    var id: Int = 1
    var name: String = "A"
    var email: String = "B"
    var password: String = "10"
    var role: String = "ok"
    
    init() {
    }

    init(id: Int, name: String, email: String, password: String, role: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.role = role
    }
}
