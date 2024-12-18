using sap.capire.moviestudioproject as db from '../db/schema';

service Movies @(path: '/movies') {
    entity Movies          as projection on db.Movies;
    entity Scenes          as projection on db.Scenes;
    entity SceneActors     as projection on db.SceneActors;
    entity Equipment       as projection on db.Equipment;
    entity EquipmentOrders as projection on db.EquipmentOrders;
    entity MoviePeople     as projection on db.MoviePeople;
    entity MovieProgress   as projection on db.MovieProgress;
}
