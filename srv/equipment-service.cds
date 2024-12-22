using sap.capire.moviestudioproject as db from '../db/schema';

service EquipmentService @(path: '/equipment') {
    @readonly
    entity Equipment          as projection on db.Equipment;

    entity EquipmentOrders    as projection on db.EquipmentOrders;
    entity EquipmentOrderItem as projection on db.EquipmentOrderItem;
    function showLowStock()                                               returns array of Equipment;
    action   CloseOrder(order : db.EquipmentOrders:ID)                    returns String;

    action   OrderEquipment(items : array of items, scene : db.Scenes:ID) returns {
        quantity : db.Equipment:quantity
    };
}

type items : {
    quantity : Integer;
    item     : db.Equipment:ID;
}
