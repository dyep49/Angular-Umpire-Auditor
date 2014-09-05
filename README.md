#Umpire Auditor

After every game, the MLB releases an incredible amount of data. In fact, every single pitch brings back more than 30 different characteristics. Umpire Auditor uses this data to track (or audit) the performance of MLB umpires, primarily by calculating the rate at which these umpires correctly calculate balls and strikes.

The application returns the worst call of the night, every night, chosen as such for being the called strike furthest from the strike zone. In addition, umpire performance statistics are calculated for each game and cumulatively. A task is run everyday at 8:30 AM eastern that updates and tweets the worst call from @umpireauditor. The gifs are not made programatically and are pretty much created whenever I wake up/get into work that day. 

##API Documentation (WORK IN PROGRESS)

Example application using API: www.businessweek.com/graphics/baseballs-worst-call-of-the-day/#/

####/api/games/date/:year/:month/:day

Returns worst call of the specified day

```javascript
{
    "homeTeam": "Baltimore Orioles",
    "awayTeam": "Minnesota Twins",
    "game": "2014-09-01T00:00:00.000Z",
    "imgDate": "2014-09-01",
    "pitch": 0.639,
    "umpire": "Kerwin Danley",
    "umpire_id": 36,
    "ballCount": 1,
    "strikeCount": 0,
    "inning": "7",
    "inningHalf": "top",
    "outs": 2
}
```

####/api/worst_call/
Returns the most recent worst call in same format as querying an individual day

####/api/umpires/
Returns all umpires with stats since 2012

```javascript
[
    {
        "name": "Tim Welke",
        "correctCalls": 6722,
        "incorrectCalls": 1184,
        "correctCallPercent": 85.02403238047053,
        "totalCalls": 7906,
        "id": 1
    },
    {
        "name": "Dale Scott",
        "correctCalls": 6672,
        "incorrectCalls": 1104,
        "correctCallPercent": 85.80246913580247,
        "totalCalls": 7776,
        "id": 2
    },
    ...

```

####/api/umpires/year/:year
Filters /api/umpires response by year

####/api/umpires/:id
Returns all games by individual umpire
```javascript
{
    "games": [
        {
            "id": 17,
            "home_team_id": 121,
            "away_team_id": 120,
            "gid": "gid_2014_03_31_wasmlb_nynmlb_1",
            "mlb_umpire_id": 427545,
            "umpire_id": 1,
            "game_date": "2014-03-31T00:00:00.000Z",
            "total_calls": 188,
            "correct_calls": 156,
            "incorrect_calls": 32,
            "home_team_abbrev": "NYM",
            "away_team_abbrev": "WSH",
            "percent_correct": 0.829787234042553,
            "umpire_name": "Tim Welke",
            "game_type": "R",
            "home_full_name": "New York Mets",
            "away_full_name": "Washington Nationals"
        },
...
```
        

####/api/days/dates
Returns all dates with a worst call

####/api/teams/
THIS ENDPOINT DOES NOT EXIST YET

Will return json with all games organized by team

####/api/teams/:id
Returns team and stats about every game

```javascript
{
    "team": {
        "id": 3,
        "team_id": 135,
        "abbreviation": "SD",
        "full_name": "San Diego Padres",
        "division_id": 203,
        "league_id": 104,
        "code": "sdn",
        "city": "San Diego",
        "name_brief": null,
        "created_at": "2014-07-15T15:04:24.175Z",
        "updated_at": "2014-07-19T18:17:54.857Z",
        "title": "Padres"
    },
    "games": [
        {
            "id": 4,
            "home_team_id": 135,
            "away_team_id": 119,
            "gid": "gid_2014_03_30_lanmlb_sdnmlb_1",
            "mlb_umpire_id": 427090,
            "umpire_id": 3,
            "game_date": "2014-03-30T00:00:00.000Z",
            "total_calls": 140,
            "correct_calls": 109,
            "incorrect_calls": 31,
            "home_team_abbrev": "LAD",
            "away_team_abbrev": "SD",
            "percent_correct": 0.778571428571429,
            "umpire_name": "Fieldin Culbreth",
            "game_type": "R",
            "home_full_name": "San Diego Padres",
            "away_full_name": "Los Angeles Dodgers"
        },
...
```












