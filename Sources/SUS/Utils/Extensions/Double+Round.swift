//
//  Double+Round.swift
//  
//
//  Created by Łukasz Stachnik on 07/05/2022.
//

import Foundation

// Specify the decimal place to round to using an enum
public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
}

// Round to the specific decimal place
public func preciseRound(
    _ value: Double,
    precision: RoundingPrecision = .ones) -> Double
{
    switch precision {
    case .ones:
        return round(value)
    case .tenths:
        return round(value * 10) / 10.0
    case .hundredths:
        return round(value * 100) / 100.0
    }
}

public func preciseRound(_ values: [Double],
                         precision: RoundingPrecision = .ones) -> [Double] {
    switch precision {
    case .ones:
        return values.map { round($0) }
    case .tenths:
        return values.map { round($0 * 10) / 10.0 }
    case .hundredths:
        return values.map { round($0 * 100) / 100.0 } 
    }
}
