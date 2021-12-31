// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetAllPokemonsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllPokemons {
      allPokemon {
        __typename
        id
        sprites {
          __typename
          front_default
          front_shiny
        }
        name
        types {
          __typename
          name
        }
        generation
        evolves_to {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "GetAllPokemons"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPokemon", type: .list(.object(AllPokemon.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPokemon: [AllPokemon?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPokemon": allPokemon.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }])
    }

    /// get range of Pokemon starting from start variable
    public var allPokemon: [AllPokemon?]? {
      get {
        return (resultMap["allPokemon"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllPokemon?] in value.map { (value: ResultMap?) -> AllPokemon? in value.flatMap { (value: ResultMap) -> AllPokemon in AllPokemon(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }, forKey: "allPokemon")
      }
    }

    public struct AllPokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("sprites", type: .object(Sprite.selections)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("types", type: .list(.object(`Type`.selections))),
          GraphQLField("generation", type: .scalar(String.self)),
          GraphQLField("evolves_to", type: .list(.object(EvolvesTo.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, sprites: Sprite? = nil, name: String? = nil, types: [`Type`?]? = nil, generation: String? = nil, evolvesTo: [EvolvesTo?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "id": id, "sprites": sprites.flatMap { (value: Sprite) -> ResultMap in value.resultMap }, "name": name, "types": types.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }, "generation": generation, "evolves_to": evolvesTo.flatMap { (value: [EvolvesTo?]) -> [ResultMap?] in value.map { (value: EvolvesTo?) -> ResultMap? in value.flatMap { (value: EvolvesTo) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// array of Sprite objects
      public var sprites: Sprite? {
        get {
          return (resultMap["sprites"] as? ResultMap).flatMap { Sprite(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "sprites")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// array of all the different Types of the queried Pokemon
      public var types: [`Type`?]? {
        get {
          return (resultMap["types"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [`Type`?] in value.map { (value: ResultMap?) -> `Type`? in value.flatMap { (value: ResultMap) -> `Type` in `Type`(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }, forKey: "types")
        }
      }

      /// which generation the queried Pokemon debuted in
      public var generation: String? {
        get {
          return resultMap["generation"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "generation")
        }
      }

      /// array of Pokemon that the queried Pokemon can evolve into
      public var evolvesTo: [EvolvesTo?]? {
        get {
          return (resultMap["evolves_to"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [EvolvesTo?] in value.map { (value: ResultMap?) -> EvolvesTo? in value.flatMap { (value: ResultMap) -> EvolvesTo in EvolvesTo(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [EvolvesTo?]) -> [ResultMap?] in value.map { (value: EvolvesTo?) -> ResultMap? in value.flatMap { (value: EvolvesTo) -> ResultMap in value.resultMap } } }, forKey: "evolves_to")
        }
      }

      public struct Sprite: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Sprites"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("front_default", type: .scalar(String.self)),
            GraphQLField("front_shiny", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(frontDefault: String? = nil, frontShiny: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Sprites", "front_default": frontDefault, "front_shiny": frontShiny])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var frontDefault: String? {
          get {
            return resultMap["front_default"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "front_default")
          }
        }

        public var frontShiny: String? {
          get {
            return resultMap["front_shiny"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "front_shiny")
          }
        }
      }

      public struct `Type`: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Type"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Type", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct EvolvesTo: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Pokemon"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Pokemon", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}
