//
//  Dependencies.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import Foundation

struct Dependencies {

    let coreDataService: CoreDataService
    let liveActivitiesService: LiveActivitiesService

    private let skStoreReviewRepository: SKStoreReviewRepository

    init(coreDataService: CoreDataService,
         liveActivitiesService: LiveActivitiesService,
         skStoreReviewRepository: SKStoreReviewRepository) {
        self.coreDataService = coreDataService
        self.liveActivitiesService = liveActivitiesService
        self.skStoreReviewRepository = skStoreReviewRepository
    }
}
