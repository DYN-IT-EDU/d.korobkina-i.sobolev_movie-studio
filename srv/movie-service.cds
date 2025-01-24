using sap.capire.moviestudioproject as db from '../db/schema';

@requires: 'authenticated-user'
service MoviesService @(path: '/movies') {
    @readonly entity Movies          as projection on db.Movies;
    @readonly entity Scenes as projection on db.Scenes;
    @readonly entity Contracts as projection on db.Contracts;
    @readonly entity Expenses as projection on db.Expenses; 
    function calculateTotalExpenses(@mandatory movieID : db.Movies:ID) returns Decimal(15,2);

    function sleep() returns Boolean;

    // // view with parameter
    // entity MovieProgress (movieID : UUID) as
    //     select from db.MovieProgresses
    //     where MovieProgresses.ID = :movieID;

}
