import Foundation

extension Comparable {
    func clamped(min: Self? = nil, max: Self? = nil) -> Self {
        if let min = min, self < min {
            return min
        }
        else if let max = max, max < self {
            return max
        }
        return self
    }

    func clamped(_ range: ClosedRange<Self>) -> Self {
        return clamped(min: range.lowerBound, max: range.upperBound)
    }
}
