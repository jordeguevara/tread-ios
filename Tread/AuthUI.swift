//
//  AuthUI.swift
//  Tread
//
//  Created by Jorde Guevara on 2/15/25.
//

import SwiftUI

//struct AuthUI: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
import SwiftUI

enum AuthMode: String, CaseIterable, Identifiable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
    
    var id: String { self.rawValue }
}

struct AuthUI: View {
    @State private var authMode: AuthMode = .signIn
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String?
    @State private var infoMessage: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Picker to choose between Sign Up and Sign In
                Picker("Authentication Mode", selection: $authMode) {
                    ForEach(AuthMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Email Input Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                if authMode == .signUp {
                    // Sign Up Flow: Validate Email
                    Button(action: {
                        // Here you’d call your email validation service
                        // Example: validateEmail(email) { success in ... }
                        infoMessage = "Validation email sent (placeholder)"
                    }) {
                        Text("Validate Email")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                } else {
                    // Sign In Flow: Send Email Link
                    Button(action: {
                        // Call your backend to send a sign-in link
                        // e.g., sendSignInLink(email) { result in ... }
                        infoMessage = "Sign-in link sent to email (placeholder)"
                    }) {
                        Text("Send Sign-In Link")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // Alternative: Use phone number OTP if deep linking is problematic
                    VStack(alignment: .leading) {
                        Text("Or use Phone OTP")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        TextField("Enter your phone number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Call your backend to send an OTP to the phone number
                        infoMessage = "OTP sent to phone number (placeholder)"
                    }) {
                        Text("Send OTP")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                
                // Display messages
                if let info = infoMessage {
                    Text(info)
                        .foregroundColor(.blue)
                        .padding(.top)
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top)
                }
                
                Spacer()
            }
            .navigationTitle("Login")
            // Handle deep linking if using email sign-in links
            .onOpenURL { url in
                // Parse the incoming URL and handle authentication logic
                // For example, extract a token or code and validate with your backend.
                print("Received URL: \(url)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


#Preview {
    AuthUI()
}
