//
//  ViewController.swift
//  PictureGallery
//
//  Created by Anuj Rai on 27/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    private enum Constants {
        static let photoUrlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        static let refreshButtonTitle = "Refresh"
    }

    private enum State {
        case pending
        case loading(spinner: SpinnerView )
        case loaded(inView: PhotoTableView, withRefreshButton: UIBarButtonItem)
        case failed(error: Error?, retryView: NoConnectionView?)
    }

    var visibleView: AddableRemovable? {
        willSet { visibleView?.removeAsSubView() }
        didSet { if let visibleView = visibleView { visibleView.addAsSubView(in: view )}}
    }

    private lazy var refreshButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: Constants.refreshButtonTitle,
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(refreshPhotoTableView))
        return barButtonItem
    }()

    @objc private func refreshPhotoTableView() {
        state = .loading(spinner: SpinnerView())
        fetchPhotos()
    }

    private var state: State = .pending {
        didSet {
            switch state {
            case .pending: visibleView = nil
            case .loading(let spinnerView): visibleView = spinnerView
            case .failed(let error, let retryView): visibleView = retryView
            if let error = error as? DataFetchingError, error == DataFetchingError.noRecords {
                UIAlertController.showNoRecordsPrompt(inParent: self)
                }
            case .loaded(let photoTableView, let refreshButton):
                self.navigationItem.rightBarButtonItem = refreshButton
                photoTableView.reloadData()
                visibleView = photoTableView
            }
        }
    }

    private lazy var tableView = PhotoTableView(frame: .zero, style: .plain)
    var photos: [Photos]?

    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ReachabilityManager.updateApplicationConnectionStatus()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        state = .loading(spinner: SpinnerView())
        fetchPhotos()
    }

    private func fetchPhotos() {

        guard let photoUrl = URL(string: Constants.photoUrlString) else { return }
        NetworkWrapper.sharedInstance.fetchMembers(for: photoUrl) { (result: Result<ResponseModel, Error>) in
            switch result {
            case .success(let responseModel):
                self.title = responseModel.pictureCollectionTitle
                self.photos = responseModel.photos
                self.state = .loaded(inView: self.tableView, withRefreshButton: self.refreshButton)

            case .failure(let error):
                self.state = .failed(error: error, retryView: NoConnectionView {} )
            }
        }
    }
}


extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VAPhotoGalleryCell = tableView.dequeueReusableCell()
        guard let photo = photos?[indexPath.row] else { return cell }
        cell.childView.configure(with: photo)

        return cell
    }
    
}



