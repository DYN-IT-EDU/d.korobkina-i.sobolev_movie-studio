using sap.capire.moviestudioproject as db from '../db/schema';

@requires: 'authenticated-user'
service ContractsService @(path: '/contracts') {
    @requires: 'ContractsViewer'
    entity Contracts as select from db.Contracts;

    type MonetaryValue {
    amount: Decimal(15,2);
    currency: String(3);
    }

    @requires: 'ContractsManager'
    action addContract(
    movieID: UUID, 
    personID: UUID @mandatory,
    roleID: UUID @mandatory,
    salary: MonetaryValue, 
    details: String
    ) returns String;

    @requires: 'ContractsManager'
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