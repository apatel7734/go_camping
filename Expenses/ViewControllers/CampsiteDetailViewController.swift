//
//  CampsiteDetailViewController.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit

class CampsiteDetailViewController: UITableViewController {

    private enum DetailRow: Int {
        case MapRow = 0
        case InfoRow
        case PhotoRow
        case DetailRowLength
    }
    
    var place: Place!
    var placeDetail: PlaceDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GoogleMapApi(apiController: ApiController()).getPlaceDetailForPlaceId(place.placeId, success: { (placeDetail) in
            self.placeDetail = placeDetail
            }) { (error) in
            
        }
    }
}

// MARK: - Tableview methods
extension CampsiteDetailViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailRow.DetailRowLength.rawValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = getCellIdForRow(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        return cell
    }
}

// MARK: - Private methods
extension CampsiteDetailViewController {
    
    private func configureCell(cell: UITableViewCell, forRow row: Int) {
        switch row {
        case DetailRow.MapRow.rawValue:
//            let mapCell = cell as! CampsiteDetailMapCell
//            mapCell.configureCellWithLocation(placeDetail)
            break
            
        default:
            break
        }
    }
    
    private func getCellIdForRow(row: Int) -> String {
        switch row {
        case DetailRow.MapRow.rawValue:
            return "mapCell"
            
        case DetailRow.InfoRow.rawValue:
            return "infoCell"
            
        case DetailRow.PhotoRow.rawValue:
            return "photoCell"
        
        default:
            return ""
        }
    }
}