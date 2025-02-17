using sap.capire.moviestudioproject as db from '../db/schema';

@requires: 'authenticated-user'
service SceneService @(path: '/scenes') {
    entity Scenes          as projection on db.Scenes;
    // entity Movies as projection on db.Movies{
    //     ID,
    //     title
    // };
    // annotate Scenes with @odata.draft.enabled;
    entity Movies as projection on db.Movies;
    entity SceneActors     as projection on db.SceneActors;
    entity Expenses as projection on db.Expenses;
    // function calculateScenesExpenses(@mandatory movieID : db.Movies:ID) returns Decimal(15,2);
    action calculateScenesExpenses(movieID : db.Movies:ID) returns Decimal(15, 2);

//     @inbound {
//         target : 'calculateScenesExpenses', requiresEntity : true
// };
    action createScene(movieID: UUID, description: String, duration: Integer, status: Integer) returns Scenes;
}
