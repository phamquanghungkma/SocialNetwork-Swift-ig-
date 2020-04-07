//
//  Protocols.swift
//  InstagramCopy
//
//  Created by Stephan Dowless on 2/7/18.
//  Copyright © 2018 Stephan Dowless. All rights reserved.
//

//protocol FeedCellDelegate {
//    func handleUsernameTapped(for cell: FeedCell)
//    func handleOptionsTapped(for cell: FeedCell)
//    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool)
//    func handleCommentTapped(for cell: FeedCell)
//    func handleConfigureLikeButton(for cell: FeedCell)
//    func handleShowLikes(for cell: FeedCell)
//    func configureCommentIndicatorView(for cell: FeedCell)
//}


protocol UserProfileHeaderDelegate {
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
    func handleFollowersTapped(for header: UserProfileHeader)
    func handleFollowingTapped(for header: UserProfileHeader)
}

//protocol NotificationCellDelegate {
//    func handleFollowTapped(for cell: NotificationCell)
//    func handlePostTapped(for cell: NotificationCell)
//}

//protocol CommentInputAccesoryViewDelegate {
//    func didSubmit(forComment comment: String)
//}
//
//protocol MessageInputAccesoryViewDelegate {
//    func handleUploadMessage(message: String)
//    func handleSelectImage()
//}
//
protocol FollowCellDelegate {
    func handleFollowTapped(for cell: FollowCell)
}
//
//protocol ChatCellDelegate {
//    func handlePlayVideo(for cell: ChatCell)
//}
//
//protocol MessageCellDelegate {
//    func configureUserData(for cell: MessageCell)
//}
//
//protocol Printable {
//    var description: String { get }
//}
//





