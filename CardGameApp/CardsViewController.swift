


import UIKit

struct AppConstants {
    static let CARD_PAIRS_VALUE = 6
   
}
class CardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalStepsLabel: UILabel!
    
    
    let viewModel = CardsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        totalStepsLabel.text = "Total Steps : \(viewModel.totalSteps)"
       
    }
    
    @IBAction func restart(){
        viewModel.totalSteps = 0;
        totalStepsLabel.text = "Total Steps : \(viewModel.totalSteps)";
        viewModel.tappedCardsArray.removeAll();
        viewModel.cards = viewModel.getCardsArray()
        collectionView.reloadData()
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 * AppConstants.CARD_PAIRS_VALUE;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell {
            let card = viewModel.cards[indexPath.item]
            cell.configureCell(card: card)
            return cell
        }
        return UICollectionViewCell()
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        viewModel.totalSteps = viewModel.totalSteps + 1
        var card = viewModel.cards[indexPath.item]
        viewModel.tappedCardsArray.append(card);
        card.toggle();
        viewModel.cards[indexPath.item] = card;
        
        if viewModel.totalSteps % 2 == 0 {
            viewModel.lastCardIndexPath = indexPath
        }
        else {
            viewModel.secondLastCardIndexPath = indexPath
        }
        
       
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        UIView.transition(with: cell.contentView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: { () -> Void in
            
        }, completion: {
            [weak self] _ in
            
            self?.totalStepsLabel.text = "Total Steps : \(self!.viewModel.totalSteps)"
            self?.collectionView.reloadData()
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                if self!.viewModel.totalSteps % 2 == 0 {
                    self?.viewModel.checkIfCardsDidMatch()
                    self?.collectionView.reloadData()
                    self?.showWinningMessage()
                }
                
            }
            
            
        })
    }
    
   
    func showWinningMessage ()
    {
        if(viewModel.isGameCompleted() == true ){
            let alert = UIAlertController(title: "Congratulations", message: "You won this game by \(viewModel.totalSteps) steps", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try another round", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
   
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2;
    }
    
     
}
