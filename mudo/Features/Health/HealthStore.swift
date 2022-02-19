//
//  HealthStore.swift
//  mudo
//
//  Created by Brett Bauman on 2/18/22.
//

import Combine
import Foundation
import HealthKit

class HealthStore {
    
    private let hkHealthStore: HKHealthStore
    
    init(hkHealthStore: HKHealthStore) {
        self.hkHealthStore = hkHealthStore
    }
    
    func requestPermissions() {
        let types = Set<HKObjectType>([
            .workoutType(),
            .activitySummaryType(),
            HKQuantityType(.stepCount),
            HKQuantityType(.appleExerciseTime),
            HKQuantityType(.appleStandTime),
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.distanceWalkingRunning),
            HKQuantityType(.distanceCycling),
            HKQuantityType(.distanceSwimming),
            HKQuantityType(.distanceDownhillSnowSports),
            HKQuantityType(.distanceWheelchair),
        ])
        
        Task {
            try await hkHealthStore.requestAuthorization(toShare: .init(), read: types)
        }
    }
    
    func entries(for date: Date) -> AnyPublisher<[HealthEntry], Never> {
        let entryPublishers = HealthDataType.allCases
            .map { self.entry(for: $0, on: date) }

        return Publishers.MergeMany(entryPublishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func entry(for healthData: HealthDataType, on date: Date) -> Future<HealthEntry, Never> {
        let predicate = HKQuery.predicateForSamples(within: date)
    
        return Future { [weak self] promise in
            let query = HKStatisticsQuery(
                quantityType: healthData.hkQuantityType,
                quantitySamplePredicate: predicate,
                options: healthData.statisticsQueryOption
            ) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else {
                    print("No data for", healthData.displayName)
                    promise(.success(HealthEntry(dataType: healthData, value: 0)))
                    return
                }
                
                let value = sum.doubleValue(for: healthData.hkUnit)
                let entry = HealthEntry(dataType: healthData, value: value)
                promise(.success(entry))
            }
            
            // todo: move out of future?
            self?.hkHealthStore.execute(query)
        }
    }
}
