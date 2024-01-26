//
//  myTableViewCell.swift
//  playVideoApp
//
//  Created by 윤규호 on 1/25/24.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let cellTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.frame.size.height - 10
        
        cellImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: 100)
        cellTitleLabel.frame = CGRect(x: imageSize + 15, y: 5, width: contentView.frame.size.width - imageSize - 20, height: 10)
    }
    
}
