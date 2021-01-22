# Spotify search case study

## Music search
### Story: The customer should be able to search for artists, albums and tracks on the Spotify catalog
### Narrative #1
```
As an online user 
I want to be able to search artists, albums and tracks
So I can always reach quickly to my favorite songs
```
#### Scenarios (Acceptance criteria)
```
Give the user has connectivity
When the user introduces an input text in the search bar
Then the app should display a list of artists, albums and tracks that match the given text
And the fetched results should be cached for offline usage
```
### Narrative #2
```
As an offline user
I want to be able to search for artists, albums and songs that have been fetched before
So I can play the songs I want
```
#### Scenarios (Acceptance criteria)
```
Given the user has no connectivity
And there´s persisted information about artists, albums and songs
When the user searches for a artists, album or song
Then the app should display the list of artists, albums and songs that matches with the introduced criteria

Given the user has no connectivity
And there is not any persisted information about artists, albums or songs
When the user begins a new search
Then the app should display an error message
```

## Use Cases
### Remote search
#### Data: 
- searchText
- API URL

#### Primary course (happy path): 
1. Introduce a text in the search bar.
2. System downloads data from the API.
3. System validates the downloaded data.
4. System creates a list of results based on the valid data.
5. System delivers the search results data.
6. System persists the fetched information.

#### Invalid data - error course (sad path): 
1. Systems delivers invalid data error.

#### No connectivity - error course (sad path): 
1. System delivers conectivity error.
---

### Local search from the cached data
#### Data: 
- searchText

#### Primary course:
1. Introduce a text in the search bar.
2. System retrieves the data from the local persisted data.
3. System created a list of results based on the cached data.
4. System delivers the results information.
