//
//  ProfileTableViewHeader.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 11/2/25.
//

import UIKit

class ProfileTableViewHeader: UIView {

  private let birthdayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Born May 21, 2004"
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 14, weight: .regular)
    return label
  }()

  private let birthdayImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "balloon")?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .secondaryLabel
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let joinedDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Joined May 2021"
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 14, weight: .regular)
    return label
  }()

  private let joinDateImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .secondaryLabel
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let userBioLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 3
    label.text = "(@ChelseaFC @dallasmavs fan && Luka Dončić and Reece James activist && @KyrieIrving Tribe && outer space enthusiast && hablo español && programmer 💻)== true"
    label.textColor = .label
    label.font = .systemFont(ofSize: 18, weight: .regular)
    return label
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "@b0bRJ24"
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 18, weight: .regular)
    return label
  }()

  private let displayNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bob"
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.textColor = .label
    return label
  }()

  private let profileAvatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 40
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "person")
    imageView.backgroundColor = .yellow
    return imageView
  }()

  private let profileHeaderImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "header")
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(profileHeaderImageView)
    addSubview(profileAvatarImageView)
    addSubview(displayNameLabel)
    addSubview(usernameLabel)
    addSubview(userBioLabel)
    addSubview(birthdayImageView)
    addSubview(birthdayLabel)
    addSubview(joinDateImageView)
    addSubview(joinedDateLabel)
    configureConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  private func configureConstraints() {
    let profileHeaderImageViewConstraints = [
      profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
      profileHeaderImageView.heightAnchor.constraint(equalToConstant: 180),
    ]

    let profileAvatarImageViewConstraints = [
      profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      profileAvatarImageView.centerYAnchor.constraint(
        equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
      profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
      profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
    ]

    let displayNameLabelConstraints = [
      displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
      displayNameLabel.topAnchor.constraint(
        equalTo: profileAvatarImageView.bottomAnchor, constant: 20),
    ]

    let usernameLabelConstraints = [
      usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
      usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
    ]

    let userBioLabelConstraints = [
      userBioLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
      userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
    ]

    let birthdayImageViewConstraints = [
      birthdayImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
      birthdayImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 20)
    ]

    let birthdayLabelConstraints = [
      birthdayLabel.leadingAnchor.constraint(
        equalTo: birthdayImageView.trailingAnchor, constant: 2),
      birthdayLabel.bottomAnchor.constraint(equalTo: birthdayImageView.bottomAnchor),
    ]

    let joinDateImageViewConstraints = [
      joinDateImageView.leadingAnchor.constraint(
        equalTo: birthdayLabel.trailingAnchor, constant: 16),
      joinDateImageView.centerYAnchor.constraint(equalTo: birthdayImageView.centerYAnchor)
    ]

    let joinedDateLabelConstraints = [
      joinedDateLabel.leadingAnchor.constraint(
        equalTo: joinDateImageView.trailingAnchor, constant: 2),
      joinedDateLabel.centerYAnchor.constraint(equalTo: joinDateImageView.centerYAnchor),
      joinedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      joinedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
    ]

    NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
    NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
    NSLayoutConstraint.activate(displayNameLabelConstraints)
    NSLayoutConstraint.activate(usernameLabelConstraints)
    NSLayoutConstraint.activate(userBioLabelConstraints)
    NSLayoutConstraint.activate(birthdayImageViewConstraints)
    NSLayoutConstraint.activate(birthdayLabelConstraints)
    NSLayoutConstraint.activate(joinDateImageViewConstraints)
    NSLayoutConstraint.activate(joinedDateLabelConstraints)
  }
}
