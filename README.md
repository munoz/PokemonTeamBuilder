# Pokemon Team Builder

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Build a team of Pokémon for strategy or fun!

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Games
- **Mobile:** This will be a strictly mobile application with the ability to share an image generated within the app. 
- **Story:** Build Pokémon team and share with friends. 
- **Market:** 
- **Habit:** This app could be used when periodically as reference when playing other Pokémon games.
- **Scope:** Scope will be narrow, primarily used to build team. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login, Signup, Logout
<img src='https://recordit.co/9tLRp5Sc6z.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
* Create a team of Pokémon
* Edit existing team
* Search for Pokémon search
* Select Pokémon moves 
* Choose Pokémon ability
* Choose Pokémon item
* Choose Pokémon nature
* Share team
* Generate image of team

**Optional Nice-to-have Stories**

* Share team to another user
* Copy existing team
* Pokémon Go integration

### 2. Screen Archetypes

* Login
   * Insert your username and password to access your account
   * Signup button if you don't have an account
* Signup
   * Enter a unique username
   * Enter a password and one more time to confirm
   * Click signup to take you to Team List
* Team List (First Screen that is shown)
   * Navigation bar with three options: SharePage, Teams, Logout
   * Able to scroll through your teams
   * Button to add a new team to your list (takes you to Team Display page)
* Team Display
   * 1-6 slots to make up your pokemon team
   * Save your team once finished to take you to your team list
   * Click on the poke bar to choose your pokemon (takes you to Pokemon Search page)
* Pokemon Search
   * Search the pokemon you want
   * Click the pokemon to choose its details (take you to Pokemon Editing page)
* Pokemon Editing
   * Choose 1-4 moves for your pokemon (may not be 0)
   * Able to select an item (not necessary)
   * Mandatory to select the following: Ability, Nature, Gender
   * Save button to take you Team Display
   * There will be a back button if you don't want that pokemon


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* SharePage
* Your Teams
* Logout

**Flow Navigation** (Screen to Screen)

* Login Page -> Teams List Page
* Login Page -> Signup Page -> Team List Page
* Team List add button -> Team Display page
* Team Display pokemon bar -> Pokemon Search Page
* Pokemon clicked in Search Results -> Pokemon Editing
* Pokemon Editing saved -> Team Display page

## Wireframes
![name-of-you-image](https://i.imgur.com/Mc9ks8A.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | username      | String   | unique username for the user |
   | password      | String   | password to access acount |
   
#### Teams

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the team (default field) |
   | user          | Pointer  | Connect the team to its respective user |
   | team          | Array    | Consists of the pokemon team |
   | name          | String   | Name of the Team |

### Networking
[Code Snippets will be added when implemented]

- Login Screen
      - (Read/GET) Query for the user that will login
- Signup Screen
      - (Create/POST) Create a new user for the app
- Team List Screen
      - (Read/GET) Query for all the teams that the user made
- Team Display Screen
      - (Create/POST) Create a new team for the user
      - (Read/GET) Get the team that is being worked on
- Pokemon Editing Screen
      - (Create/POST) Create the pokemon that will be added to the team

#### [OPTIONAL:] Existing API Endpoints
##### Pokemon API: PokeAPI
- Base URL - [https://pokeapi.co](https://pokeapi.co)

   HTTP Verb | Endpoint                        | Description |
   --------- | ------------------------------- | ----------- |
    `GET`    | /pokemon?limit=807&offset=0     | get all pokemon up to Gen 7 |
    `GET`    | /pokemon/name                   | return specific pokemon by name |
    `GET`    | /item-attribute/holdable-active | get limited battle active items (not include mega stones or z-crystal) |
    `GET`    | /nature                         | return all natures pokemon can learn |
