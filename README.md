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

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
![name-of-you-image](https://i.imgur.com/Mc9ks8A.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | username      | String   | unique username for the user |
   | password      | String   | password to access acount |
   | firstname     | String   | User's first name |
   | lastname      | String   | User's last name |

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
