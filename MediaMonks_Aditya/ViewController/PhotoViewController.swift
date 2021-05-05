//
//  PhotoViewController.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var albumId: Int?
    var viewModel = PhotoViewModel()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                    #selector(PhotoViewController.handleRefresh),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Photo List ...")
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        setupTableView()
        getPhotoDataList()
    }

    //MARK: Photo Data APi
    private func getPhotoDataList() {
        self.view.startActivityIndicator()
        viewModel.getPhotoDataList(id: albumId ?? 0) { [weak self] (data, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showError(error)
                }
                self?.tableView.reloadData()
                self?.view.stopActivityIndicator()
            }
        }
    }

    //MARK:- Setup Table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: CellPlaceholder.PhotoTableCell)
    }

    //MARK:- Table View Refresh
    @objc private func handleRefresh() {
        getPhotoDataList()
        refreshControl.endRefreshing()
    }

}

// MARK: Table view delegate and datasource method
extension PhotoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellPlaceholder.PhotoTableCell, for: indexPath) as? PhotosTableViewCell else {
            return UITableViewCell()
        }
        cell.photoData = viewModel.photoData?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photoDetailVC = UIStoryboard(name: Constants.kMainStoryboard,bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else { return }
        photoDetailVC.photoData = viewModel.photoData?[indexPath.row]
        navigationController?.pushViewController(photoDetailVC, animated: true)
    }
}


