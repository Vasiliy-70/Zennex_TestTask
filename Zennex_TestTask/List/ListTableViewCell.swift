//
//  ListTableViewCell.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import UIKit

protocol IListTableCell: class {
	var avatar: UIImage? { get set }
	var name: String? { get set }
	var info: String? { get set }
}

final class ListTableViewCell: UITableViewCell {
	private var photo: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		return imageView
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()
	
	private var infoText: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()
	
	private enum Constraints {
		static let photoOffset: CGFloat = 10
		static let photoHeight: CGFloat = 100
		static let photoWidth: CGFloat = 100
		
		static let nameLabelOffset: CGFloat = 10
		static let nameLabelHeight: CGFloat = 40
		
		static let infoTextOffset: CGFloat = 10
		static let infoTextHeight: CGFloat = 40
		
		static let borderSpace: CGFloat = 10
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

private extension ListTableViewCell {
	func setupConstraints() {
		self.setupImagesConstraints()
		self.setupLabelsConstraints()
	}
	
	func setupImagesConstraints() {
		self.addSubview(self.photo)
		self.photo.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.photo.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.borderSpace),
			self.photo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.photo.heightAnchor.constraint(equalToConstant: Constraints.photoHeight),
			self.photo.widthAnchor.constraint(equalToConstant: Constraints.photoWidth)
		])
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.nameLabel)
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.topAnchor.constraint(equalTo: self.photo.bottomAnchor, constant: Constraints.photoOffset),
			self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.nameLabel.heightAnchor.constraint(equalToConstant: Constraints.nameLabelHeight)
		])
		
		self.addSubview(self.infoText)
		self.infoText.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.infoText.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: Constraints.nameLabelOffset),
			self.infoText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.infoText.heightAnchor.constraint(equalToConstant: Constraints.infoTextHeight),
			self.infoText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.infoTextOffset)
		])
	}
}

// MARK: IListTableCell

extension ListTableViewCell: IListTableCell {
	var avatar: UIImage? {
		get {
			self.photo.image
		}
		set {
			self.photo.image = newValue
		}
	}
	
	var name: String? {
		get {
			self.nameLabel.text
		}
		set {
			self.nameLabel.text = newValue
		}
	}
	
	var info: String? {
		get {
			self.infoText.text
		}
		set {
			self.infoText.text = newValue
		}
	}
}
