//
//  ViewController.swift
//  TestMiOS
//
//  Created by Adina porea on 24/05/16.
//  Copyright © 2016 Adina Porea. All rights reserved.
//

import UIKit
import BDataProvider

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let teamProvider = TeamProvider()
    private var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        teamProvider.teamUIDelegate = self
        refreshTeam()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        cell.setup(with: members[indexPath.row])
        cell.onShowEncription = { [weak self] in
            self?.getEncryption(forIndex: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        members.count
    }
    
    private func getEncryption(forIndex: Int) {
        members[forIndex].loadingEncription = true
        tableView.reloadRows(at: [IndexPath(row: forIndex, section: 0)], with: .none)
        DispatchQueue.global().async { [weak self] in
            self?.members[forIndex].encryptionKey = self?.members[forIndex].developer.encryptionKey
            DispatchQueue.main.async {
                self?.members[forIndex].loadingEncription = false
                self?.tableView.reloadRows(at: [IndexPath(row: forIndex, section: 0)], with: .none)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.members[forIndex].encryptionKey = nil
                    self?.tableView.reloadRows(at: [IndexPath(row: forIndex, section: 0)], with: .none)
                }
            }
        }
    }
}

extension ViewController: TeamDataUpdaterDelegate {
    func teamListShouldBeRefreshed() {
        members.removeAll()
        tableView.reloadData()
        refreshTeam()
    }
    
    func informationForMemberWithIDhasChanged(memberID: String) {
        refreshMember(id: memberID)
    }
    
    private func refreshTeam() {
        teamProvider.provideTeamMemberIDs { [weak self] list in
            for member in list {
                self?.refreshMember(id: member)
            }
        }
    }
    
    private func refreshMember(id: String) {
        teamProvider.provideMemberInformationForID(id: id) { [weak self] developer in
            guard let developer = developer else { return }
            if let index = self?.members.firstIndex(where: { $0.memberId == id }) {
                if developer.photoURL != self?.members[index].developer.photoURL {
                    self?.members[index].image = nil
                    self?.members[index].imageDownloaded = false
                }
                self?.members[index].developer = developer
                self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            } else if let self = self {
                self.members.append(Member(memberId: id, developer: developer))
                self.tableView.insertRows(at: [IndexPath(row: self.members.count - 1, section: 0)], with: .none)
                self.updateImage(forIndex: self.members.count - 1)
            }
        }
    }
    
    private func updateImage(forIndex: Int) {
        let photoUrl = members[forIndex].developer.photoURL
        UIImage.fromUrl(members[forIndex].developer.photoURL) { [weak self] imageData in
            guard self?.members[forIndex].developer.photoURL == photoUrl else {
                return
            }
            self?.members[forIndex].image = imageData
            self?.members[forIndex].imageDownloaded = true
            self?.tableView.reloadRows(at: [IndexPath(row: forIndex, section: 0)], with: .none)
        }
    }
}
