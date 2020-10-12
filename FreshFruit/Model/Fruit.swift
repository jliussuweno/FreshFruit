import Foundation
class Fruit {
    var id: Int = 1
    var nameFruit: String = "Apel"
    var price: String = "30000"
    var stock: String = "10"
    var image: String = "image"
    var qty: String = "0"
    
    init() {
    }

    init(id: Int, nameFruit: String, price: String, stock: String, image: String) {
        self.id = id
        self.nameFruit = nameFruit
        self.price = price
        self.stock = stock
        self.image = image
    }
}
