const cds = require("@sap/cds");
const { request } = require("express");

class ContractsService extends cds.ApplicationService {
    init(){
        this.on('addContract', this.addContract);
        this.on('removeContract', this.removeContract);
        return super.init();
    }

    async addContract(req) {
        console.log(req)
        console.log('Incoming Request:', req);
        const { Contracts } = this.entities;
        console.log(typeof(req));
        console.log(req.movieID, req.personID);
        const { movieID, personID, roleID, salary, details } = req;

        const result = await INSERT.into(Contracts).entries({
            movie_ID: movieID,
            person_ID: personID,
            role_ID: roleID,
            salary: { amount: salary, currency: "USD" },
            details: details,
        });

        if (result) {
            return { success: true, message: "Contract added successfully" };
        } else {
            return { success: false, message: "Failed to append contract" };
        }
    }

    async removeContract(req) {
        const { Contracts } = this.entities;
        const ID = req;

        const result = await DELETE.from(Contracts).where({ ID });

        if (result) {
            return { success: true, message: `Contract with ID ${ID} has been removed.` };
        } else {
            return { success: false, message: `Failed to remove contract with ID ${ID}.` };
        }
    }
};
module.exports = ContractsService;