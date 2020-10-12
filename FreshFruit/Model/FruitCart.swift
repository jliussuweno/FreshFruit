import Foundation
class FruitCart {
    var nameFruit: String = "Apel"
    var price: String = "30000"
    var qty: String = "1"
    var image: String = "imageUrl"
    var stock: String = "0"
    
    init() {
    }
    
    init(nameFruit: String, price: String, qty: String, image: String, stock: String) {
        self.nameFruit = nameFruit
        self.price = price
        self.qty = qty
        self.image = image
    }
}
