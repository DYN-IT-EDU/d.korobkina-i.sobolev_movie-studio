const cds = require("@sap/cds");

class ContractsService extends cds.ApplicationService {
    init(){
        this.before(['addContract','removeContract'], this.checkExistense);
        this.after('addContract', this.appendDetails);
        this.on('addContract', this.appendContracts);
        this.on('removeContract', this.deleteFromContracts);
        return super.init();
    }


    async appendContracts(req) {
        const { Contracts } = this.entities;
        const { movieID, personID, roleID, salary, details } = req.data;
        const result = await INSERT.into(Contracts).entries({
            movie_ID: movieID,
            person_ID: personID,
            role_ID: roleID,
            salary: { amount: salary, currency: "USD" },
            details: details,
        });
        const newContract = await SELECT.one('ID').from(Contracts).where({
            movie_ID: movieID,
            person_ID: personID,
            role_ID: roleID
        });
        if (result) {
            return { success: true, message: `Contract with id ${newContract.ID} added successfully`, ID: newContract.ID };
        } else {
            req.error(500, "Failed to append contract");
        }
    }

    async deleteFromContracts(req) {
        const { Contracts } = this.entities;
        const { ID } = req.data;
        const result = await DELETE.from(Contracts).where({ ID });

        if (result) {
            return { success: true, message: `Contract with ID ${ID} has been removed.` };
        } else {
            
            return { success: false, message: `Failed to remove contract with ID ${ID}.` };
        }
    }

    
    async checkExistense(req){
        const { Contracts } = this.entities;

        if (req.event === "addContract"){
            const {movieID, personID, roleID } = req.data;
            const existingContract = await SELECT.one.from(Contracts)
            .where({ movie_ID: movieID, person_ID: personID, role_ID: roleID });

        if (existingContract) {
            req.error(400, `Contract already exists for MovieID ${movieID}, PersonID ${personID}, and RoleID ${roleID}.`);
        }
        console.log("movieid in checking", movieID);

        }
        if (req.event === "removeContract"){
            const { ID } = req.data;
            const contract = await SELECT.one.from(Contracts).where({ ID });

            if (!contract) {
                req.error(404, `Contract with ID ${ID} does not exist.`);
            }
        }

    }
    async appendDetails(data){

        const ID = data.ID;
        const { Contracts } = this.entities;
        const currentContract = await SELECT.one(Contracts, ['details']).where({ ID });
        const currentDetails = currentContract.details || "";
        const appendedDetails = `${currentDetails} newly added contract`;
        const result = await UPDATE(Contracts)
        .set({ details: appendedDetails })
        .where({ ID });
        if (result === 1) {
            return { success: true, message: "Details updated successfully", details: appendedDetails };
        } else {
            req.error(500, "Failed to update contract details");
        }

    }
};
module.exports = ContractsService;