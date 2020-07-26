

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImg.layer.cornerRadius = 10
    }
    
    func configureCell(card: Card) {
        let isVisible = card.isNumberVisible ?? false
        titleLabel.text = card.title
        if(isVisible){
            recipeImg.isHidden  = true;
            titleLabel.isHidden  = false;
           
        }
        else {
            recipeImg.isHidden  = false;
            titleLabel.isHidden  = true;
        }
        
       
    }
}
