const cds = require("@sap/cds");

class SceneService extends cds.ApplicationService {
    init() {
        this.on('calculateScenesExpenses', this.returnScenesExpenses);
        this.on('changeStatusToPending', this.setStatusToPending);

        return super.init();
    }

    async setStatusToPending(req) {
        const sceneID = req.params[0].ID;
        const db = cds.db;
        const { Scenes } = this.entities;
        const updatedScene = await db.run(
            UPDATE(Scenes)
                .set({ status: 1 })
                .where({ ID: sceneID })
        )
        return updatedScene;
       }

    async returnScenesExpenses(req) {
        const movieID = req;
        const db = cds.db;
        const { Expenses } = this.entities;

        const totalSceneExpenses = await db.run(
            SELECT('SUM(expense_amount) as total')
                .from(Expenses)
                .where({movie_ID: movieID})
        )
        return {
            value: totalSceneExpenses
        };
    }
}

module.exports = SceneService;
