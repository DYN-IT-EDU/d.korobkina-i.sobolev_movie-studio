using sap.capire.moviestudioproject as db from '../db/schema';

service SceneService @(path: '/scenes') {
    entity Scenes          as projection on db.Scenes;
    entity SceneActors     as projection on db.SceneActors;
    entity Expenses as projection on db.Expenses;
    function calculateScenesExpenses(@mandatory movieID : db.Movies:ID) returns Decimal(15,2);
}
