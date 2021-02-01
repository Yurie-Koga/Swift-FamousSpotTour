//
//  ListViewController.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/30.
//

import UIKit

class ListViewController: UITableViewController {

    let realm = RealmFactory.create()
    var locationId = 4 {
        didSet {
            self.setLocation()
        }
    }
    var locations: [Location] = []
    let cellId = "spots"
    
    var notMyPage = true

    override func viewDidLoad() {
        super.viewDidLoad()
        super.tableView.register(ListViewCell.self, forCellReuseIdentifier: cellId)
        super.title = "Spot List"
        if notMyPage {
            self.setLocation()
        }
    }

    private func setLocation() {
        self.locations = []
        for location in self.realm.objects(Location.self)  {
            if location.tagsId.contains(self.locationId) {
                self.locations.append(location)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! ListViewCell
        cell.update(with: locations[indexPath.row])
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailsViewController(locationId: locations[indexPath.row].id)
        super.navigationController?.pushViewController(nextViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
}
