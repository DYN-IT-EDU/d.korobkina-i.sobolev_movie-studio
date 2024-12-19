using sap.capire.moviestudioproject as db from '../db/schema';

service Movies @(path: '/movies') {
    entity Movies          as projection on db.Movies;
    entity Contracts     as projection on db.Contracts;
    entity MovieProgress   as projection on db.MovieProgress;
}
