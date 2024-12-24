using sap.capire.moviestudioproject as db from '../db/schema';

service TestService @(path: '/test') {
    action testAction(movieID: UUID, details: String) returns String;
}

service ContractsService @(path: '/contracts') {
    entity Contracts as select from db.Contracts;

    type MonetaryValue {
    amount: Decimal(15,2);
    currency: String(3);
    }

    type Contract{
    movieID: UUID;
    personID: UUID @mandatory;
    roleID: UUID @mandatory;
    salary: MonetaryValue;
    details: String;
    }

    action addContract(
    input: Contract 
    ) returns String;

    action removeContract(ID: UUID) returns {
        success: Boolean;
        message: String;
    };

    // action addContract(
    // movieID: UUID, 
    // personID: UUID @mandatory,
    // roleID: UUID @mandatory,
    // salary: MonetaryValue, 
    // details: String
    // );
}