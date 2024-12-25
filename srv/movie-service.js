const cds = require("@sap/cds");

class MoviesService extends cds.ApplicationService {
    init() {
        this.on('calculateTotalExpenses', this.returnTotalExpenses);
        this.on('sleep', async () => {
            try {
                let dbQuery = ' Call "sleep"( )'
                let result = await cds.run(dbQuery, { })
                cds.log().info(result)
                return true
            } catch (error) {
                cds.log().error(error)
                return false
            }
            })
        return super.init();
    }

    async returnTotalExpenses(req) {
        console.log("req.data:", req.data);

        const { movieID } = req.data;

        const { Expenses, Contracts, Scenes } = this.entities;

        const db = cds.db;
        const totalSceneExpenses = await db.run(
            SELECT('SUM(expense_amount) as total')
                .from(Expenses)
                .where({ 'scene.movie_ID' : movieID })
        );
        
        const totalSalaries = await db.run(
                SELECT('SUM(salary_amount) as total')
                    .from(Contracts)
                    .where({ 'movie_ID': movieID })
            );
            
        const sceneExpenses = totalSceneExpenses[0]?.total || 0;
        const salaries = totalSalaries[0]?.total || 0;
        const totalExpenses = sceneExpenses + salaries;

        return totalExpenses;
    }
}

module.exports = MoviesService;
