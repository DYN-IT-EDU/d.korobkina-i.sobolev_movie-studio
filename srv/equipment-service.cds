using sap.capire.moviestudioproject as db from '../db/schema';

service EquipmentService @(path: '/equipment') {
    entity Equipment       as projection on db.Equipment;
    entity EquipmentOrders as projection on db.EquipmentOrders;
}
