# Ravn-Challenge-V3-Adriana-Gutierrez
Repository for the Ravn iOS Code Challenge. 

## Project description
- The project consists of an iOS application that allows the user to browse the list of all available Pokémon in the API [Dex Server](https://dex-server.herokuapp.com/) and check its details consuming the API [PokeApi](https://pokeapi.co/docs/v2#pokemon-species).  
- The user can filter the list searching by the pokemon name, follow the evolution chain of the pokemon if available and choose the type of the pokemon's sprite to be presented.  
- The application shows if the internet connection is lost.
- The application supports Spanish and English.  
- The application requires iOS 15.

## General overview of the architecture and classes responsibilities
- The application is built with the MVVM model.
- In the Model folder we can find the basic struct Pokemon, its responsibility is to represent the data consumed from the API. There's a couple of structs more that help Pokemon.
- In the view models we consume the services classes to get the data from the API and the pass it to the UI.
- The services classes expose a publisher that publishes the data already decoded to a type Response (PokemonDetailsResponse or AllPokemonQueryResponse).
- Views observe the view models in order to be updated.
## Running instructions.
- Clone or download the repository.
- Open the project file with XCode.
- Choose an iOS simulator or preferably an actual iOS device since the reachability feature doesn't work porperly in the simulators.
- Give the device the permissions to be run.
- Press the play button at the top bar in XCode.
## Gifs or screenshots of the working application.
The following media content was taken with a device with the language set to Spanish.
- Basic flow of the application 
<img src="https://github.com/adrianaguu/Ravn-Challenge-V3-Adriana-Gutierrez/blob/main/App%20Gifs:Screenshots/basicFlow.gif" width="240" />
- Failed to load data alert
<img src="https://github.com/adrianaguu/Ravn-Challenge-V3-Adriana-Gutierrez/blob/main/App%20Gifs:Screenshots/Failed%20to%20load%20data%20alert.jpeg" width="240" />
-Failed to load data message
<img src="https://github.com/adrianaguu/Ravn-Challenge-V3-Adriana-Gutierrez/blob/main/App%20Gifs:Screenshots/Failed%20to%20Load%20Data.jpeg" width="240" />
- Connectivity Issue alert
<img src="https://github.com/adrianaguu/Ravn-Challenge-V3-Adriana-Gutierrez/blob/main/App%20Gifs:Screenshots/Connectivity%20Issue.jpeg" width="240" />

## Assumptions
- The pokemons can only be searched by the start of its name. Example: Searching 'Aur' won't show Ivysaur as a result but it will show Aurorus.
- The search is case sensitive.
- The name of the pokemons and the generation they are part of are considered proper names, so they aren’t translated.

## List of technologies used.
- Swift
- SwiftUI
- [Apollo IOS](https://www.apollographql.com/docs/ios/)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
