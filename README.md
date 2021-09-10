<h1 align="center">
  MSDebouncer
</h1>

<h5 align="center">Simple debouncer to use in your iOS apps</h5>

## Demo
<p align="center">
<img src="https://raw.githubusercontent.com/moridaffy/MSDebouncer/main/demo.gif" alt="Demo video" width="300"/>
</p>


## How to install?
### Manually
* Just copy the file ```Debouncer.swift``` into your project

### Swift Package Manager
* Enter following URL as package repository URL: ```https://github.com/moridaffy/msdebouncer/```
* Use `main` branch

## Usage
Here's how you can use MSDebouncer in your app:

```swift
import MSDebouncer

class ViewController: UIViewController {

  ...

  private var debouncer: Debouncer<String>?

  private func setupDebouncer() {
    self.debouncer = Debouncer(outputType: String.self, debounceTime: 1.0, callback: { value in
      APIManager.shared.searchForItems(query: value)
    })
  }

  private func textFieldUpdated(with text: String) {
    debouncer?.setValue(text)
  }
}
```

This snippet shows basic implementation of Debouncer when trying to implement live search in your app. It allows you to skip sending network requests to your API after each letter typed while still giving impression of instant search.
