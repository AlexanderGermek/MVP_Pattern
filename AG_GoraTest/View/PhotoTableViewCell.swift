//
//  PhotoTableViewCell.swift
//  AG_GoraTest
//
//  Created by iMac on 29.01.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    var photoImageURL: URL?{
        didSet{
            photoImageView.image = nil
            updateImage()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1).cgColor
        cellView.layer.borderWidth = 1
        cellView.layer.cornerRadius = 5
        cellView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0);
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }

//presenter
func updateImage(){
    if let url = photoImageURL{
        self.indicator.startAnimating()

        DispatchQueue.global(qos: .default).async {
            let dataOfURL = try? Data(contentsOf: url)

            DispatchQueue.main.async {
                if url == self.photoImageURL{
                    if let imageData = dataOfURL{
                        self.photoImageView.image = UIImage(data: imageData)
                    }
                    self.cellView.layoutIfNeeded()

                    self.indicator.stopAnimating()
                }
            }
        }
    }
}
}
