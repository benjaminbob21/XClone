//
//  ProfileViewController.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 10/30/25.
//

import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileTableViewHeader(frame: .zero)

    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileHeaderView.frame = CGRect(x: 0, y: 0, width: profileTableView.bounds.width, height: 1)
        profileTableView.tableHeaderView = profileHeaderView
        updateTableHeaderSizeIfNeeded()
        configureConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeaderSizeIfNeeded()
    }

    private func configureConstraints() {
        let profileTableViewConstraints = [
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(profileTableViewConstraints)
    }

    private func updateTableHeaderSizeIfNeeded() {
        guard let header = profileTableView.tableHeaderView else { return }
        let availableWidth = profileTableView.bounds.width
        guard availableWidth > 0 else { return }

        if header.frame.width != availableWidth {
            header.frame.size.width = availableWidth
        }

        header.setNeedsLayout()
        header.layoutIfNeeded()

        let targetSize = CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height)
        let requiredHeight = header.systemLayoutSizeFitting(targetSize).height

        if header.frame.height != requiredHeight {
            header.frame.size.height = requiredHeight
            profileTableView.tableHeaderView = header
        }
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}