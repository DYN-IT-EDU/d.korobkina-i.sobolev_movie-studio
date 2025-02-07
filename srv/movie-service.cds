using sap.capire.moviestudioproject as db from '../db/schema';

service MoviesService @(path: '/movies') {

    entity Movies    as projection on db.Movies
        actions {
            @(Common.SideEffects: {TargetProperties: ['in/movieStatus_code', ]})
            @(Common.IsActionCritical: true)
            action setReleasedStatus() returns Movies;
        };


    entity Scenes    as projection on db.Scenes;

    @readonly
    entity Contracts as projection on db.Contracts;

    @readonly
    entity Expenses  as projection on db.Expenses; // Expose Expenses

    // entity Contracts     as projection on db.Contracts;
    function calculateTotalExpenses( @mandatory movieID : db.Movies:ID) returns Decimal(15, 2);
// view with parameter
/*entity MovieProgress(movieID : UUID) as
    select from db.MovieProgresses
    where
        MovieProgresses.ID = :movieID;*/

}

annotate MoviesService with @(requires: 'MovieManager');
