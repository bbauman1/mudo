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
        
        hkHealthStore.requestAuthorization(toShare: .init(), read: types) { _, _ in }
    }
    
    func entries(for date: Date) -> AnyPublisher<[HealthEntry], Never> {
        let entryPublishers = HealthDataType.allCases
            .map { self.entry(for: $0, on: date) }

        return Publishers.MergeMany(entryPublishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    func workoutEntries(for date: Date) -> AnyPublisher<[WorkoutEntry], Never> {
        let subject = PassthroughSubject<[WorkoutEntry], Never>()
        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: HKQuery.predicateForSamples(within: date),
            limit: HKObjectQueryNoLimit,
            sortDescriptors: nil
        ) { _, samples, _ in
            guard let samples = samples else {
                print("No workout samples for", date)
                subject.send([])
                return
            }
                
            let entries = samples
                .compactMap { $0 as? HKWorkout }
                .map {
                    WorkoutEntry(
                        workoutName: $0.workoutActivityType.displayName,
                        durationValue: $0.duration,
                        durationMeasurement: .time(.minutes),
                        energyValue: ($0.totalEnergyBurned?.doubleValue(for: .largeCalorie()) ?? 0),
                        energyMeasurement: .calories)
                }
            subject.send(entries)
        }
        
        hkHealthStore.execute(query)
        return subject.eraseToAnyPublisher()
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
            
            self?.hkHealthStore.execute(query)
        }
    }
}
