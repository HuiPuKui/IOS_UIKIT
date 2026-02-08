//
//  NoteDetailVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import UIKit
import ImageSlideshow
import LeanCloud
import FaveButton
import GrowingTextView

class NoteDetailVC: UIViewController {

    var note: LCObject
    var isLikeFromWaterfallCell = false
    var delNoteFinished: (() -> ())?
    
    var comments: [LCObject] = []
    
    var isReply = false
    var commentSection = 0
    
    var replies: [ExpandableReplies] = []
    var replyToUser: LCUser?
    
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareOrMoreBtn: UIButton!
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var channelBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var likeBtn: FaveButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var favBtn: FaveButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var commentCountBtn: UIButton!
    
    @IBOutlet weak var textViewBarView: UIView!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var textViewBarBottomConstraint: NSLayoutConstraint!
    
    lazy var overlayView: UIView = {
        let overlayView = UIView(frame: self.view.frame)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        overlayView.addGestureRecognizer(tap)
        return overlayView
    }()
    
    var likeCount = 0 {
        didSet {
            self.likeCountLabel.text = self.likeCount == 0 ? "点赞" : self.likeCount.formattedStr
        }
    }
    var currentLikeCount = 0
    
    var favCount = 0 {
        didSet {
            self.favCountLabel.text = self.favCount == 0 ? "收藏" : self.favCount.formattedStr
        }
    }
    var currentFavCount = 0
    
    var commentCount = 0 {
        didSet {
            self.commentCountLabel.text = "\(self.commentCount)"
            self.commentCountBtn.setTitle(self.commentCount == 0 ? "评论" : self.commentCount.formattedStr, for: .normal)
        }
    }
    
    var author: LCUser? {
        return self.note.get(kAuthorCol) as? LCUser
    }
    
    var isLike: Bool {
        return self.likeBtn.isSelected
    }
    
    var isFav: Bool {
        return self.favBtn.isSelected
    }
    
    var isReadMyNote: Bool {
        if let user = LCApplication.default.currentUser,
           let author = self.author,
           user == author {
            return true
        } else {
            return false
        }
    }
    
    init?(coder: NSCoder, note: LCObject) {
        self.note = note
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("必须传一些参数进来以构造本对象，不能单纯的用 storyboard!.instantiateViewController 构造本对象")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
//        self.imageSlideshow.setImageInputs([
//            ImageSource(image: UIImage(named: "1")!),
//            ImageSource(image: UIImage(named: "2")!),
//            ImageSource(image: UIImage(named: "3")!)
//        ])
//        
//        let imageSize = UIImage(named: "1")!.size
//        self.imageSlideShowHeight.constant = (imageSize.height / imageSize.width) * screenRect.width
        
        self.setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.adjustTableHeaderViewHeight()
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareOrMore(_ sender: Any) {
        self.shareOrMore()
    }
    
    @IBAction func like(_ sender: Any) {
        self.like()
    }
    
    @IBAction func fav(_ sender: Any) {
        self.fav()
    }
    
    @IBAction func comment(_ sender: Any) {
        self.comment()
    }
    
    @IBAction func postCommentOrReply(_ sender: Any) {
        if !self.textView.isBlank {
            
            if !self.isReply {
                self.postComment()
            } else {
                self.postReply()
            }
            
            self.hideAndResetTextView()
        }
    }
    
}
