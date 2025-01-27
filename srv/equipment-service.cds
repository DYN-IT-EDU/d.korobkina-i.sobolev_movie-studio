using sap.capire.moviestudioproject as db from '../db/schema';

@requires: 'authenticated-user'
service EquipmentService @(path: '/equipment') {
    @readonly
    entity Equipment                            as projection on db.Equipment;

    @restrict: [
    { grant: 'READ', to: ['WarehouseStaff'] }
    ]
    entity EquipmentOrders                      as
        select from db.EquipmentOrders {
            ID,
            scene,
            status,
            date,
            items
        };

    entity EquipmentOrderItem                   as projection on db.EquipmentOrderItem;
    entity MovieProgresses                        as projection on db.MovieProgresses;

    entity MoviesViewWithParameter(p1 : String) as
        select from db.Movies
        where
            ID = :p1;

    function sleep()                                                      returns Boolean;
    function showLowStock()                                               returns array of Equipment;
    @requires: 'StaffMember'
    action   CloseOrder(order : db.EquipmentOrders:ID)                    returns String;

    @requires: 'StaffMember'
    action OrderEquipment(items : array of items, scene : db.Scenes:ID) returns {
        quantity : db.Equipment:quantity
    };
}

type items : {
    quantity : Integer;
    item     : db.Equipment:ID;
}
