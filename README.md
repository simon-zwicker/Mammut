
# Mammut

Mammut is a Swift package designed to simplify and enhance REST API interactions using URLSession and Swift’s async/await concurrency model. It provides a robust, easy-to-use abstraction layer that makes networking in your applications faster, more reliable, and more readable.

## Features
- Smart API Calls: Simplifies making RESTful requests by wrapping URLSession in a streamlined interface.
- Modern Concurrency: Built from the ground up with Swift’s async/await for cleaner, asynchronous code.
- Error Handling: Implements structured error handling for network failures, invalid responses, or decoding errors.
- Customization: Easily configure request headers, query parameters, and timeouts.
- Decodable Integration: Directly decode JSON responses into Swift models with minimal boilerplate.

## Requirements
- Swift 5.0 or later
- Compatible with macOS, iOS, watchOS, and tvOS

## Installation

### Swift Package Manager (SPM)
To use Mammut in your project, add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-repository/Mammut.git", from: "1.0.0")
]
```

Then, add `Mammut` as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["Mammut"])
]
```

## Usage

### Create Environment
```swift
enum NetworkEnv {
	case develop
	case production

	var schema: String {
		switch self {
		case .develop: "http"
		case .production: "https"
		}
	}

	var host: String {
		switch self {
		case .develop: "localhost:8080"
		case .production: "mydomain.com"
		}
	}

	var path: String {
		switch self {
		case .develop: "/api/v2"
		case .production: "/api/v1"
		}
	}

	var components: URLComponents {
		var components = URLComponents()
		components.scheme = schema
		components.host = host
		components.path = path
		return components
	}
}
```

### Create Network Struct
```swift
import Foundation
import Mammut

struct Network {

	static var environment: NetworkEnv = .production

	static private var api: Mammut {
		Mammut(components: environment.components, loglevel: .debug)
	}

	static func request<T: Codable>(
		_ T: T.Type,
		environment: NetworkEnv = .production,
		endpoint: Endpoint
	) async throws(MammutError) -> T {
		self.environment = environment
		let result = await req(T.self, endpoint )
		switch result {
		case .success(let success): return success
		case .failure(let failure): throw failure.self
		}
	}

	static private func req<T: Codable>(
		_ T: T.Type,
		_ endpoint: Endpoint
	) async -> Result<T, MammutError> {
		await api.request(endpoint, error: ErrorObj.self)
	}
}
```
### Create API Enum
```swift
import Foundation
import Mammut

enum ExampleAPI {
	case randomFact(language: String?)
	case todayFact(language: String?)
	case login(Login)
}

extension ExampleAPI: Endpoint {
	var path: String {
		switch self {
		case .randomFact: "/facts/random"
		case .todayFact: "/facts/today"
		case .login: "/login"
		}
	}

	var method: MammutMethod {
		switch self {
		case .login: .post
		default: .get
		}
	}

	var headers: [MammutHeader] {
		[.content(.type("application/json"))]
	}

	var parameters: [String : Any] {
		var parameters: [String: Any] = [:]

		switch self {
		case .randomFact(language: let lang), .todayFact(language: let lang):
			guard let lang else { return parameters }
			parameters["language"] = lang
		case .login(let login):
			parameters = login.dictionary
		}

		return parameters
	}

	var parametersUrl: [String : Any] { [:] }

	var encoding: Encoding {
		switch self {
		case .login: .json
		default: .url
		}
	}
}
```

### Call
```
do {
	self.fact = try await Network.request(Fact.self, endpoint: ExampleAPI.randomFact(language: "en"))
} catch let error as LocalizedError {
	print(error.complete)
}
```

## Contributing
Contributions are welcome! Please feel free to submit a pull request or file an issue.

## License
Mammut is available under the MIT license. See the LICENSE file for more information.
