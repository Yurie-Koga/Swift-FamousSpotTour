//
//  DetailsViewController.swift
//  FamousSpotTour
//
//  Created by Yurie.K on 2021-01-25.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestoreSwift
import RealmSwift

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    /* this part shouold be in a external model file - start */
    // example category data
    private struct category {
        var id: Int
        var name: String
    }
    private let categories: [category] = [
        category(id: 1, name: "Park"),
        category(id: 2, name: "Market"),
        category(id: 3, name: "Restaurant"),
    ]
    
    // example tag data
    private struct tag {
        var id: Int
        var name: String
    }
    private let tags: [tag] = [
        tag(id: 1, name: "Family"),
        tag(id: 2, name: "Cheep"),
        tag(id: 3, name: "Old"),
    ]
    enum TagData: Int {
        case Family = 1
        case Cheep = 2
        case Old = 3
    }
    
    // example location data
    struct location {
        var id: Int
        var name: String
        var picture: URL
        var subPictures: [URL]
        var numOfLike: Int
        var numOfDislike: Int
        var headline: String
        var description: String
        var categories: [Int]
        var tags: [Int]
        var latitude: Double
        var longitude: Double
    }
    /* this part shouold be in a external model file - end */
    

    var locationId = Int()
    var sampleLocation: location!
    var userDatas: [UserData] = [] {
        didSet {
            UserData.saveToFile(userDatas: userDatas)
        }
    }
    
    /* ----- UI elements ----- - start */
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let topIV: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
        
    var tagStackView = UIStackView()
    let tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    let headlineLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
        
    var clickStackView = UIStackView()
    let clickView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Thumbs Up"), for: .normal)
        btn.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return btn
    }()
    let likeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let dislikeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Thumbs Down"), for: .normal)
        btn.addTarget(self, action: #selector(dislikeTapped), for: .touchUpInside)
        return btn
    }()
    let dislikeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let visitedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Not Visited", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(visitedTapped), for: .touchUpInside)
        return btn
    }()
    
    let subPictCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .red
        return collection
    }()
    /* ----- UI elements ----- - end */

    
    init(locationId: Int) {
        self.locationId = locationId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load UserData
        if let savedUserDatas = UserData.loadFromFile() {
            userDatas = savedUserDatas
        }
        // new location: add record
        if getUserData(locationId: locationId) == nil {
            userDatas.append(UserData(locationId: locationId, isVisited: false))
        }
        
        // fetch the latest data
        let spotsRepository: SpotsRepository = SpotsRepository()
        let strID = "id_" + String(describing: locationId)
        spotsRepository.find(by: strID) { (data) in
            print(data)
            // set data with mixing actual and sample data
            let lati = (data["geo"] as! GeoPoint).latitude
            let longti = (data["geo"] as! GeoPoint).longitude
            self.sampleLocation = location(id: data["id"] as! Int, name: data["name"] as! String,
                                           picture: URL(string: data["picture"] as! String)!,
                                           subPictures: [
                                            URL(string: "https://firebasestorage.googleapis.com/v0/b/famousspottour.appspot.com/o/CanadaPlaceImage.jpg?alt=media&token=302b15f4-11d3-4ba1-a036-15dee85a8bb1")!,
                                            URL(string: "https://firebasestorage.googleapis.com/v0/b/famousspottour.appspot.com/o/CapilanoSuspensionBridgeImage.jpg?alt=media&token=6d24347f-dbf6-40df-bb6e-0ef6211ce510")!,
                                            URL(string: "https://firebasestorage.googleapis.com/v0/b/famousspottour.appspot.com/o/StanleyPark.jpg?alt=media&token=0d20daf4-5231-40e4-bcf4-c4e9086020d6")!,
                                            
                                           ],
                                           numOfLike: data["like"] as! Int, numOfDislike: data["dislike"] as! Int,
                                           headline: data["headline"] as! String,
                                           description: data["description"] as! String,
                                           categories: [1, 2], tags: [2, 3],
                                           latitude: lati, longitude: longti)
            
            self.initUI()
        }
    }
        
    func initUI() {
        view.backgroundColor = .white

        // scroll view
        view.addSubview(scrollView)
        scrollView.matchParent()
        
        // top image
        generateTopImage()
        
        // tag
        generateTags()
        tagView.addSubview(tagStackView)    // to avoid setting width anchor for tagStackView
        
        // location name
        nameLabel.text = sampleLocation.name
        // headline
        headlineLabel.text = sampleLocation.headline
        // description
        descriptionLabel.text = sampleLocation.description
        // map with annotation
        generateMapView()
        
        // like, dislike, visited
        clickStackView.layoutIfNeeded()
        generateClicks()
        
        // sub pictures
        let subPictureLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        subPictureLayout.sectionInset = UIEdgeInsets.zero
        let subPicturesCV:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: subPictureLayout)
        subPicturesCV.translatesAutoresizingMaskIntoConstraints = false
        subPicturesCV.dataSource = self
        subPicturesCV.delegate = self
        subPicturesCV.register(SubPictureCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        subPicturesCV.backgroundColor = .white
        subPicturesCV.isScrollEnabled = false

        // contain all elements expect top image view
        let subVSV = VerticalStackView(arrangedSubviews: [
            tagView,
            nameLabel,
            headlineLabel,
            descriptionLabel,
            mapView,
            clickStackView,
            subPicturesCV,
        ], spacing: 20)
        subVSV.isLayoutMarginsRelativeArrangement = true
        subVSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        // main stack view
        let mainVSV = VerticalStackView(arrangedSubviews: [
            topIV,
            subVSV,
        ], spacing: 20)
        scrollView.addSubview(mainVSV)
        
        // allow scrol only vertically
        NSLayoutConstraint.activate([
            mainVSV.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            mainVSV.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            mainVSV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            mainVSV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25),
            mainVSV.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        // resize
        mapView.constraintWidth(equalToConstant: 300)
        mapView.constraintHeight(equalToConstant: 300)
        view.layoutIfNeeded()   // need to update the UI before get sizes
        tagView.constraintHeight(equalToConstant: tagStackView.frame.height)
        let lWidth = subVSV.frame.size.width / 2 - 30
        subPictureLayout.itemSize = CGSize(width: lWidth, height: lWidth)
        let cvHeight = Int(lWidth) * ((sampleLocation.subPictures.count + 1) / 2)
        subPicturesCV.constraintHeight(equalToConstant: CGFloat(cvHeight))
        
    }
    
    @objc func visitedTapped() {
        var isVisited = (visitedBtn.tag == 1) ? true : false
        isVisited = !isVisited  // switch
        if var userData = getUserData(locationId: sampleLocation.id) {
            userData.isVisited = isVisited
            for i in 0..<userDatas.count {
                if userDatas[i].locationId == userData.locationId {
                    userDatas.remove(at: i)
                    userDatas.insert(userData, at: i)
                    break
                }
            }
        }
        setVisitedBtnTitle(isVisited: isVisited)
    }
    
    @objc func likeTapped() {
        updateDBIncrement(colName: "like")
        
        // keep displayed number, not the number from the latest database
        likeLabel.text = String(describing: sampleLocation.numOfLike + 1)
        likeBtn.isEnabled = false
    }
    
    @objc func dislikeTapped() {
        updateDBIncrement(colName: "dislike")
        
        // keep displayed number, not the number from the latest database
        dislikeLabel.text = String(describing: sampleLocation.numOfDislike + 1)
        dislikeBtn.isEnabled = false
    }
    
    func generateTopImage() {
        ViewController.share.fetchImage(url: sampleLocation.picture) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.topIV.image = image
            }
        }
    }
    
    func generateTags() {
        var labels = [PaddingLabel]()
        
        for tag in sampleLocation.tags {
            if let tagName = TagData(rawValue: tag) {
//                print("tag: \(tagName)")
                let lbl = PaddingLabel(top: 3, bottom: 3, left: 7, right: 7)
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.text = String(describing: tagName)
                lbl.layer.borderWidth = 1.0
                lbl.layer.cornerRadius = 2
                lbl.font = UIFont.systemFont(ofSize: 13)
                lbl.textColor = UIColor(hex: "#3EC6FF")
                lbl.layer.borderColor = UIColor(hex: "#3EC6FF")?.cgColor
                labels.append(lbl)
            }
        }
        
        tagStackView = HorizontalStackView(arrangedSubviews: labels, spacing: 10)
    }
    
    func generateMapView() {
        let annotation = MKPointAnnotation()
        annotation.title = sampleLocation.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: sampleLocation.latitude, longitude: sampleLocation.longitude)
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func generateClicks() {
        likeLabel.text = String(describing: sampleLocation.numOfLike)
        dislikeLabel.text = String(describing: sampleLocation.numOfDislike)
        if let userData = getUserData(locationId: sampleLocation.id) {
            setVisitedBtnTitle(isVisited: userData.isVisited)
        }
        
        clickStackView = HorizontalStackView(arrangedSubviews: [
            likeBtn, likeLabel,
            dislikeBtn, dislikeLabel,
            visitedBtn,
        ], spacing: 10, distribution: .fillProportionally)
    }
    
    func getUserData(locationId: Int) -> UserData? {
        for userData in userDatas {
            if userData.locationId == locationId {
                return userData
            }
        }
        return nil
    }
    
    func setVisitedBtnTitle(isVisited: Bool) {
        if isVisited {
            visitedBtn.setTitle("✔️ Visited", for: .normal)
        } else {
            visitedBtn.setTitle("Not Visited", for: .normal)
        }
        visitedBtn.tag = isVisited ? 1 : 0
    }
    
    func updateDBIncrement(colName: String) {
//        print("\n\nwill start DB update.........")
        let spotsRepository: SpotsRepository = SpotsRepository()
        let strID = "id_" + String(describing: sampleLocation.id)
        let db: Firestore = Firestore.firestore()
        
        // check original value
//        spotsRepository.find(by: strID) { (data) in
//            print("before update:")
//            let stamp = data["updated_at"] as? Timestamp
//            let updatedAt = stamp?.dateValue()
//            print("id: \(String(describing: data["id"])), \(colName): \(String(describing: data[colName])), updated_at: \(String(describing: updatedAt))")
//        }
        
        let sfReference = db.collection(spotsRepository.name).document(strID)
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let sfDocument: DocumentSnapshot
            do {
                try sfDocument = transaction.getDocument(sfReference)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            guard let oldLikeCount = sfDocument.data()?[colName] as? Int else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve number of like from snapshot \(sfDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }

            // Note: this could be done without a transaction
            //       by updating the population using FieldValue.increment()
            transaction.updateData([colName: oldLikeCount + 1, "updated_at": Timestamp(date: Date())], forDocument: sfReference)
            return nil

        }) { (object, error) in
            if let error = error {
                print("Transaction failed: \(error)")
            } else {
                print("Transaction successfully committed!")
                // check result
//                spotsRepository.find(by: strID) { (data) in
//                    print("after update:")
//                    let stamp = data["updated_at"] as? Timestamp
//                    let updatedAt = stamp?.dateValue()
//                    print("id: \(String(describing: data["id"])), \(colName): \(String(describing: data[colName])), updated_at: \(String(describing: updatedAt))")
//                }
            }
        }
    }
    
    
    // sub pictures
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleLocation.subPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SubPictureCollectionViewCell
                
        ViewController.share.fetchImage(url: sampleLocation.subPictures[indexPath.row]) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.pictureIV.image = image
            }
        }
        return cell
    }
    
    // row selected: will be implemented as needed
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("\(indexPath.row) is tapped!")
//    }
}
