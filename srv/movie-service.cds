using sap.capire.moviestudioproject as db from '../db/schema';

service Movies @(path: '/movies') {
    entity Movies          as projection on db.Movies;
    entity MoviePeople     as projection on db.MoviePeople;
    entity MovieProgress   as projection on db.MovieProgress;
}
