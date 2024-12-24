const cds = require("@sap/cds");

class MoviesService extends cds.ApplicationService {
    init() {
        this.on('calculateTotalExpenses', this.calculateTotalExpenses);
        return super.init();
    }

    async calculateTotalExpenses(req) {
        console.log("req:", req);
        const movieID = req;
        console.log("movieid = ", movieID)
        const { Expenses, Contracts, Scenes } = this.entities;
        console.log(Scenes);

        const db = cds.db;

        const totalSceneExpenses = await db.run(
            SELECT('SUM(expense_amount) as total')
                .from(Expenses)
                .where({ 'scene.movie_ID': movieID })
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
