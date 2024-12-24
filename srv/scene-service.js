const cds = require("@sap/cds");

class ScenesService extends cds.ApplicationService {
    init() {
        this.on('calculateScenesExpenses', this.calculateScenesExpenses);
        return super.init();
    }

    async calculateScenesExpenses(req) {
        const movieID = req;
        const db = cds.db;
        // const { Expenses, Scenes } = this.entities;
        // const totalSceneExpenses = await db.run(
        //     SELECT('SUM(expense_amount) as total')
        //         .from(Scenes)
        //         .join(Expenses)
        //         .on('Scenes.ID = Expenses.scene_ID')
        //         .where({ 'Scenes.movie_ID': movieID })
        // );
        const { Expenses } = this.entities;

        const totalSceneExpenses = await db.run(
            SELECT('SUM(expense_amount) as total')
                .from(Expenses)
                .where('scene.movie_ID = ', movieID)
        )
        return totalSceneExpenses;
    }
}

module.exports = ScenesService;