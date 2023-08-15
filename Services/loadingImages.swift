import SwiftUI

// A SwiftUI view to load and display images from a URL
struct LoadingImages: View {
    
    // Enum to track the loading state of the image
    private enum LoadState {
        case loading, success, failure
    }
    
    // Observable object that handles loading the image data
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            // Start a data task to load the image data from the URL
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                // Notify the UI that the data has changed
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    // State object to manage the image loading process
    @StateObject private var loader: Loader
    
    // Images to show during different loading states
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    // Initialize the view with a URL and optional loading/failure images
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    // Select the appropriate image based on the loading state
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
