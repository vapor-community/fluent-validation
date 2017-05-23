import Fluent

@testable import FluentValidators

internal class MockDriver: Driver {
    let idKey = "id"
    
    let idType: IdentifierType = .int
    let keyNamingConvention: KeyNamingConvention = .snake_case
    var queryLogger: QueryLogger? = nil

    func makeConnection(_ type: ConnectionType) throws -> Connection {
        return DummyConnection()
    }
}

internal class DummyConnection: Connection {
    var isClosed = false
    var queryLogger: QueryLogger? = nil

    func query<E>(_ query: RawOr<Query<E>>) throws -> Node where E : Entity {
        let existingEmails: [Node] = [
            .string("jim@test.com"),
            .string("tim@test.com"),
            .string("sara@test.com")
        ]
        
        let existingUsernames: [Node] = [
            .string("Jimmy3131"),
            .string("TimTom97"),
            .string("DarkLord69")
        ]
        
        let fullResult = Node.array([
            .object([
                "email": existingEmails[0],
                "username": existingUsernames[0]
                ]),
            .object([
                "email": existingEmails[1],
                "username": existingUsernames[1]
                ]),
            .object([
                "email": existingEmails[2],
                "username": existingUsernames[2]
                ])
            ])

        guard let filters = query.wrapped?.filters, filters.count >= 1 else {
            return fullResult
        }

        for filter in filters {
            switch filter {
            case .some(let filter):
                switch filter.method {
                case .compare(let key, _, let value):
                    switch key {
                    case "email":
                        guard !existingEmails.contains(value) else {
                            return fullResult
                        }
                        
                    case "username":
                        guard !existingUsernames.contains(value) else {
                            return fullResult
                        }
                        
                    default:
                        break
                    }
                    
                    
                default:
                    return fullResult
                }
                
            default:
                return fullResult
            }
        }
        
        return Node.array([])
    }
    
    func raw(_ raw: String, _ values: [Node]) throws -> Node {
        return Node.array([])
    }
}

internal final class MockUser: Entity {
    let storage = Storage()

    init(row: Row) throws {}
    
    func makeRow() throws -> Row {
        return Row()
    }
}

