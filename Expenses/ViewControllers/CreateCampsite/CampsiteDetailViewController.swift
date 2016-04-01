//
//  CampsiteDetailViewController.swift
//  Expenses
//
//  Created by Miyuki Suzuki on 11/19/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import UIKit
import CoreLocation

class CampsiteDetailViewController: UITableViewController, UIPopoverPresentationControllerDelegate, UIViewControllerTransitioningDelegate {

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

        navigationController?.navigationBarHidden = false
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        GoogleMapApi(apiController: ApiController.sharedInstance).getPlaceDetailForPlaceId(place.placeId, success: { (placeDetail) in
            self.placeDetail = placeDetail
            self.tableView.reloadData()
            }) { (error) in
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .OverCurrentContext
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let popover = PopoverPresentationController(presentedViewController: presented, presentingViewController: source)
        popover.setXOffset(20.0)
        popover.setYOffset(220.0)
        return popover
    }
    
    @IBAction func createTripButtonTapped(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("CreateTripPopoverViewController") as! CreateTripPopoverViewController
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .Custom
        vc.delegate = self
        vc.campingTrip = GTLGocampingCampingTrip()
        vc.campingTrip.locationPoint = GTLGocampingGeoPt()
        vc.campingTrip.addressString = placeDetail?.address
        vc.campingTrip.locationPoint.latitude = placeDetail?.geometry?.location?.latitude
        vc.campingTrip.locationPoint.longitude = placeDetail?.geometry?.location?.longitude
        
        presentViewController(vc, animated: true, completion: nil)
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case DetailRow.MapRow.rawValue:
            return 200
            
        case DetailRow.PhotoRow.rawValue:
            if let photos = placeDetail?.photos {
                return photos.count == 0 ? 0 : 100
            } else {
                return 0
            }
            
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = getCellIdForRow(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        configureCell(cell, forRow: indexPath.row)
        
        return cell
    }
}

// MARK: - InfoCell action methods
extension CampsiteDetailViewController: CampsiteDetailInfoCellDelegate {
    
    func phoneButtonTapped(phoneNumber: String!) {
        let alert = UIAlertController(title: "Call \(phoneNumber)", message: "Do you want to make a call ?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Call", style: .Default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func websiteButtonTapped(website: NSURL!) {
        UIApplication.sharedApplication().openURL(website)
    }
}

// MARK: - CreateTripPopoverVC delegate methods
extension CampsiteDetailViewController: CreateTripPopoverVCDelegate {
    
    func createTripSuccessed(popOverVC: CreateTripPopoverViewController) {
        popOverVC.dismissViewControllerAnimated(true) {
            if let viewControllers = self.navigationController?.viewControllers {
                for vc in viewControllers {
                    if(vc is ListCampingTripsViewController){
                        self.navigationController?.popToViewController(vc, animated: true);
                    }
                }
            }
        }
    }
}

// MARK: - Private methods
extension CampsiteDetailViewController {
    
    private func configureCell(cell: UITableViewCell, forRow row: Int) {
        switch row {
        case DetailRow.MapRow.rawValue:
            let mapCell = cell as! CampsiteDetailMapCell
            let location = placeDetail?.geometry?.location
            if let aLocation = location {
                let coordinate = CLLocationCoordinate2D(latitude: Double(aLocation.latitude), longitude: Double(aLocation.longitude))
                mapCell.configureCellWithLocation(coordinate)
            }
            break
            
        case DetailRow.PhotoRow.rawValue:
            let photoCell = cell as! CampsiteDetailPhotoCell
            photoCell.configureCellWithPhoto(placeDetail?.photos)
            break
            
        case DetailRow.InfoRow.rawValue:
            let infoCell = cell as! CampsiteDetailInfoCell
            infoCell.configureCellWithPlaceDetail(placeDetail, delegate: self)
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
            return "photoCollectionCell"
        
        default:
            return ""
        }
    }
}