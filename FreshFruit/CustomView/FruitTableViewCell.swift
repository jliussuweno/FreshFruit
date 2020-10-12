import UIKit

class FruitTableViewCell: UITableViewCell {

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var nameFruitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    var quantity: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        incrementButton.layer.cornerRadius = 4
        incrementButton.clipsToBounds = true
        
        decrementButton.layer.cornerRadius = 4
        decrementButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func updateQuantity(_ sender: UIButton) {
        if Double(sender.tag % 2) != 0 {
            quantity = quantity + 1
            fruitList[(sender.tag - 1) / 2].qty = String(Int(fruitList[(sender.tag - 1) / 2].qty)! + 1)
        } else if quantity > 0 {
            quantity = quantity - 1
            fruitList[sender.tag / 2].qty = String(Int(fruitList[sender.tag / 2].qty)! - 1)
        }
        
        decrementButton.isEnabled = quantity > 0
        decrementButton.backgroundColor = !decrementButton.isEnabled ? .gray : .systemBlue
        
        self.quantityLabel.text = String(quantity)
    }
}
