//
//  TableCell.swift
//  TestMiOS
//
//  Created by FloreaIulian on 1/18/22.
//  Copyright © 2022 Adina Porea. All rights reserved.
//

import Foundation
import UIKit
import BDataProvider

class TableCell: UITableViewCell {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var imageLoadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var codingLevel: UILabel!
    @IBOutlet weak var encryptionButton: UIButton!
    @IBOutlet weak var encryptionLoading: UIActivityIndicatorView!
    @IBOutlet weak var encryptionLable: UILabel!
    
    var onShowEncription: (() -> Void)?
    
    func setup(with member: Member) {
        name.text = member.developer.name
        address.text = member.developer.address
        codingLevel.text = member.developer.codingLevel
        if let imageData = member.image, let image = UIImage(data: imageData) {
            profileImage.image = image
            placeHolderView.isHidden = true
            imageLoadIndicator.isHidden = true
            imageLoadIndicator.stopAnimating()
        } else {
            profileImage.image = nil
            placeHolderView.isHidden = false
            imageLoadIndicator.isHidden = member.imageDownloaded
            member.imageDownloaded ? imageLoadIndicator.stopAnimating() : imageLoadIndicator.startAnimating()
        }
        placeHolderView.layer.cornerRadius = placeHolderView.frame.size.width / 2
        encryptionButton.isHidden = member.loadingEncription || member.encryptionKey != nil
        encryptionLoading.isHidden = !member.loadingEncription
        member.loadingEncription ? encryptionLoading.startAnimating() : encryptionLoading.stopAnimating()
        encryptionLable.text = member.encryptionKey
    }
    
    @IBAction private func showEncryption(_ sender: Any) {
        onShowEncription?()
    }
}

