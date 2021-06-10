//
//  PopularMoviewViewController.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit

class PopularMoviesViewController: UIViewController {
    
    private var movies: [Movie]? {
        didSet {
            self.popularCollectionViewDataSource.movies = movies
            self.collectionView.reloadData()
        }
    }
    private var movieRepository: MovieRepository?
    private var operationQueueHandler = NetworkImageOperationQueueHandler()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var popularCollectionViewDataSource = {
        return PopularCollectionViewDataSource(operationQueueHandler: operationQueueHandler)
    }()
    
    lazy var popularCollectionViewDelegate = {
        return PopularCollectionViewDelegate(operationQueueHandler: operationQueueHandler)
    }()
    
    init(movieRepository: MovieRepository?) {
        self.movieRepository = movieRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(movieRepository: MovieNetworkRepository())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollectionView()
        getMovies()
    }
    
    fileprivate func setupCollectionView() {
        self.view.addSubview(collectionView)
        setupCollectionViewConstraint()
        collectionView.dataSource = popularCollectionViewDataSource
        collectionView.delegate = popularCollectionViewDelegate
        collectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PosterCell")
    }
    
    fileprivate func setupCollectionViewConstraint() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            self.collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    //MARK: fetch movies
    
    fileprivate func getMovies() {
        movieRepository?.getPopularMovies {[weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(_):
                break
            }
        }
    }
    
}
