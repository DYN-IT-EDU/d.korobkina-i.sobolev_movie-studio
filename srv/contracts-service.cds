using sap.capire.moviestudioproject as db from '../db/schema';

// @requires: 'any'
service ContractsService @(path: '/contracts') {
    entity Contracts as select from db.Contracts;

    type MonetaryValue {
    amount: Decimal(15,2);
    currency: String(3);
    }

    action addContract(
    movieID: UUID, 
    personID: UUID @mandatory,
    roleID: UUID @mandatory,
    salary: MonetaryValue, 
    details: String
    ) returns String;


    action removeContract(ID: UUID) returns {
        success: Boolean;
        message: String;
        ID : UUID;
    };

    // action addContract(
    // input: Contract 
    // ) returns String;

    // action addContract(
    // movieID: UUID, 
    // personID: UUID @mandatory,
    // roleID: UUID @mandatory,
    // salary: MonetaryValue, 
    // details: String
    // );
}