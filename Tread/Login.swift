import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggingIn = false
    @State private var showOTP = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
//                    .textContentType(.emailAddress)
                    .padding()
                    .cornerRadius(8)
                
                SecureField("Password", text: $password)
                    .padding()
                    .cornerRadius(8)
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button(action: login) {
                    if isLoggingIn {
                        ProgressView()
                    } else {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                
                // NavigationLink to OTP view (hidden until activated)
                NavigationLink(destination: OTPView(), isActive: $showOTP) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
    
    func login() {
        isLoggingIn = true
        errorMessage = nil
        
        // Replace with your actual API call.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoggingIn = false
            // For example, if login is successful:
            showOTP = true
            // If failed, set errorMessage accordingly.
        }
    }
}
