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

class MovieDetailViewController: BaseViewController {
    
    let network = TMDBAPI.shared
    var similarPage = 1
    var recommandPage = 1
    
    var movieData: SearchedMovie.Result?
    var posterImageList: [[MovieSuggestion.Result]] = [[],[],[]]
    var posterList: [MovieImage.Poster] = [MovieImage.Poster(filePath: "")]
    
    let movieTitleLabel = UILabel().then {
        $0.font = Font.bold20
    }
    
    lazy var suggestionMovieTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight =  240
        $0.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieData else {
//            print("movieData 없음")
            return
        }
//        print(movieData.id)
        // TODO: 영화제목이 화면을 넘어갈 시, 자동 수평 스크롤이 되도록 만들기
        movieTitleLabel.text = movieData.title
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieSuggestion(type: .similarMovie,
                                                  movieId: movieData.id,
                                                  page: similarPage),
                            model: MovieSuggestion.self) { data,_  in
                self.posterImageList[0] = data?.results ?? []
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieSuggestion(type: .recommandationMovie,
                                                  movieId: movieData.id,
                                                  page: recommandPage),
                            model: MovieSuggestion.self) { data,_  in
                self.posterImageList[1] = data?.results ?? []
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) { [self] in
            network.request(api: .movieImage(movieId: movieData.id),
                            model: MovieImage.self) { data,_ in
                self.posterList = data?.posters ?? []
                group.leave()
            }
        }
        group.notify(queue: .main) { [self] in
            self.suggestionMovieTableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubviews(movieTitleLabel,
                         suggestionMovieTableView)
    }
    
    override func configureLayout() {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.id, 
                                                       for: indexPath) as? MovieDetailTableViewCell
        else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "비슷한 영화"
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "추천 영화"
        } else if indexPath.row == 2 {
            cell.titleLabel.text = "포스터"
        }
        
        if posterImageList[indexPath.row].isEmpty && indexPath.row != 2 {
            cell.emptyLabel.isHidden = false
            cell.emptyLabel.text = "제안드릴 영화가 없네요."
            return cell
        }
        cell.emptyLabel.isHidden = true
        
        cell.movieCollectionView.tag = indexPath.row
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.prefetchDataSource = self
        cell.movieCollectionView.register(MovieDetailCollectionViewCell.self,
                                          forCellWithReuseIdentifier: MovieDetailCollectionViewCell.id)
        cell.movieCollectionView.reloadData()
        
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return posterImageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.id,
                                                            for: indexPath) as? MovieDetailCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        // TODO: 포스터 이미지가 없는 경우 어떻게 처리 할 것인가?
        // filePath가 없다면 셀생성을 하지 않기??
        if collectionView.tag == 2 {
            
            let data = posterList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.filePath)")
            cell.posterImageView.kf.setImage(with: url)
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
        
        guard let movieData else {
            print("movieData 없음")
            return
        }
        for indexPaths in indexPaths {
            func prefetch(type: TMDBRequest.SuggestionType, page: Int) {
                guard page < 50 else {
                    return
                }
                network.request(api: .movieSuggestion(type: type,
                                                      movieId: movieData.id, page: page),
                                page: page,
                                model: MovieSuggestion.self) { data, _  in
                    self.posterImageList[collectionView.tag].append(contentsOf: data?.results ?? [])
                    collectionView.reloadData()
                }
            }
            if posterImageList[collectionView.tag].count - 3 <= indexPaths.item {
                
                if collectionView.tag == 0 {
                    similarPage += 1
                    prefetch(type: .similarMovie, page: similarPage)
                } else if collectionView.tag == 1 {
                    recommandPage += 1
                    prefetch(type: .recommandationMovie, page: recommandPage)
                }
            }
        }
    }
}

private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("Cancel Prefetch \(indexPaths)")
}



