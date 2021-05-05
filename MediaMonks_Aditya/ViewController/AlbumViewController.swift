//
//  ViewController.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = AlbumViewModel()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                    #selector(AlbumViewController.handleRefresh),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Album Data ...")
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album"
        getAlbumData()
        setupTableView()
    }

    //MARK: Album API data
    private func getAlbumData() {
        self.view.startActivityIndicator()
        viewModel.getAlbumData { [weak self] (data, error) in
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
    private func setupTableView(){
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: CellPlaceholder.AlbumCell)
    }

    //MARK:- Table View Refresh
    @objc private func handleRefresh() {
        getAlbumData()
        refreshControl.endRefreshing()
    }

}

// MARK: Table view delegate and datasource method
extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellPlaceholder.AlbumCell, for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        cell.albumData = viewModel.albumData?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photoVC = UIStoryboard(name: Constants.kMainStoryboard, bundle: nil).instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else {
            return
        }
        photoVC.albumId = viewModel.albumData?[indexPath.row].id
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
