using sap.capire.moviestudioproject as db from '../db/schema';

@requires: 'authenticated-user'
service SceneService @(path: '/scenes') {
    entity Scenes          as projection on db.Scenes actions {
        @(Common.SideEffects: {TargetProperties: ['in/status', ]})
        action changeStatusToPending();

    };
    entity Movies as projection on db.Movies;
    entity SceneActors     as projection on db.SceneActors;
    entity Expenses as projection on db.Expenses;
    action calculateScenesExpenses(movieID : db.Movies:ID) returns Decimal(15, 2);
    action createScene(movieID: UUID, description: String, duration: Integer, status: Integer) returns Scenes;
}
