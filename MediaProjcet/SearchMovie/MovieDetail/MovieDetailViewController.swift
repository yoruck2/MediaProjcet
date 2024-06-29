//
//  MovieDetailViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import UIKit

import Kingfisher
import SnapKit
import Then

// TODO: 디코딩 모델까지 enum 으로 만들수 있을까?
//enum DecodingModel<T: Decodable> {
//    case searchedMovie
//    case movieSuggestion
//    case movieImage
//    
//    var type: T {
//        switch self {
//        case .searchedMovie:
//            return SearchedMovie.self as! T
//        case .movieSuggestion:
//            return MovieSuggestion.self as! T
//        case .movieImage:
//            return MovieImage.self as! T
//        z
//        }
//    }
//}

class MovieDetailViewController: UIViewController {
    
    let network = TMDBAPI.shared
    var page = 1
    
    var movieData: SearchedMovie.Result?
    var posterImageList: [[MovieSuggestion.Result]] = [[],[],[]]
    var posterList: [MovieImage.Poster] = [MovieImage.Poster(filePath: "")]
    
    let movieTitleLabel = UILabel().then {
        $0.font = Font.bold20
    }
    
    lazy var suggestionMovieTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight =  240
        $0.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieData else {
            print("movieData 없음")
            return
        }
        movieTitleLabel.text = movieData.title
        configureHierachy()
        configureLayout()
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieSuggestion(type: .similarMovie, movieId: movieData.id), model: MovieSuggestion.self) { data,_  in
                self.posterImageList[0] = data?.results ?? []
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieSuggestion(type: .recommandationMovie, movieId: movieData.id), model: MovieSuggestion.self) { data,_  in
                self.posterImageList[1] = data?.results ?? []
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieImage(movieId: movieData.id), model: MovieImage.self) { data,_ in
                self.posterList = data?.posters ?? []
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.suggestionMovieTableView.reloadData()
        }
    }
    
    func configureHierachy() {
        view.addSubviews(movieTitleLabel,
                         suggestionMovieTableView)
    }
    
    func configureLayout() {
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        suggestionMovieTableView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.id, for: indexPath) as! MovieDetailTableViewCell
    
        if indexPath.row == 0 {
            cell.titleLabel.text = "비슷한 영화"
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "추천 영화"
        } else if indexPath.row == 2 {
            cell.titleLabel.text = "포스터"
        }
        
        cell.movieCollectionView.tag = indexPath.row
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.register(MovieDetailCollectionViewCell.self,
                                          forCellWithReuseIdentifier: MovieDetailCollectionViewCell.id)
        print(indexPath.row)
        cell.movieCollectionView.reloadData()

        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterImageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.id, 
                                                      for: indexPath) as! MovieDetailCollectionViewCell
        if collectionView.tag == 2 {
            let data = posterList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.filePath)")
            cell.posterImageView.kf.setImage(with: url)
            print(url as Any)
            return cell
            
        } else {
            let data = posterImageList[collectionView.tag][indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
            cell.posterImageView.kf.setImage(with: url)
            return cell
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        
        guard let movieData else {
            print("movieData 없음")
            return
        }
        for indexPaths in indexPaths {
            if posterImageList[collectionView.tag].count - 3 <= indexPaths.item {
                if collectionView.tag == 0 {
                    page += 1
                    network.request(api: .movieSuggestion(type: .similarMovie, movieId: movieData.id), page: page, model: MovieSuggestion.self) { data, _  in
                        self.posterImageList[0] = data?.results ?? []
                        self.suggestionMovieTableView.reloadData()
                    }
                } else if collectionView.tag == 1 {
                    page += 1
                    network.request(api: .movieSuggestion(type: .recommandationMovie, movieId: movieData.id), page: page, model: MovieSuggestion.self) { data, _  in
                        self.posterImageList[1] = data?.results ?? []
                        self.suggestionMovieTableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}
