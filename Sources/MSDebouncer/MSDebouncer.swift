import Foundation

class MSDebouncer<T> {
  let outputType: T.Type
  
  var debounceTime: TimeInterval
  var callback: ((T?) -> Void)
  
  private(set) var timer: Timer?
  
  private var latestValue: T?
  
  init(outputType: T.Type, debounceTime: TimeInterval = 1.5, callback: @escaping ((T?) -> Void)) {
    self.outputType = outputType
    self.debounceTime = debounceTime
    self.callback = callback
  }
  
  func setValue(_ value: T?) {
    latestValue = value
    
    invalidateTimer()
    
    self.timer = Timer.scheduledTimer(
      timeInterval: debounceTime,
      target: self,
      selector: #selector(timerFired),
      userInfo: nil,
      repeats: false
    )
  }
  
  @objc private func timerFired() {
    callback(latestValue)
    latestValue = nil
    
    invalidateTimer()
  }
  
  private func invalidateTimer() {
    timer?.invalidate()
    timer = nil
  }
}
