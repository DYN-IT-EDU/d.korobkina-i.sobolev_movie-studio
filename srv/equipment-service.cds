using sap.capire.moviestudioproject as db from '../db/schema';

service EquipmentService @(path: '/equipment') {
    @readonly
    entity Equipment       as
        projection on db.Equipment {
            ID,
            name,
            type,
            quantity,

        };

    entity EquipmentOrders as
        select from db.EquipmentOrders
        excluding {
            scene
        };

    //entity ShowEquipmentByType(gr : String) as select * from Equipment;
    function showLowStock()                                          returns array of Equipment;

    action   OrderEquipment(item : db.Equipment:ID, order : Integer) returns {
        quantity : db.Equipment:quantity
    }


}
