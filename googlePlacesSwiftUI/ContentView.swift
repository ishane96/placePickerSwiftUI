//
//  ContentView.swift
//  googlePlacesSwiftUI
//
//  Created by Achintha Kahawalage on 2021-07-21.
//

import SwiftUI
import GooglePlaces

struct ContentView: View {
    @State var address = ""
    @State var shouldOpenPlacePicker = false
    
    var body: some View {
        VStack {
            TextField("Placeholder", text: $address)
                .onTapGesture {
                    shouldOpenPlacePicker.toggle()
                }
        }
        .sheet(isPresented: $shouldOpenPlacePicker) { PlacePicker(address: $address) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlacePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        //        filter.country = "Au"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
        
        var parent: PlacePicker
        
        init(_ parent: PlacePicker) {
            self.parent = parent
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print(place.description.description as Any)
                self.parent.address =  place.name!
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}
