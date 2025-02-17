const cds = require("@sap/cds");

class SceneService extends cds.ApplicationService {
    init() {
        this.on('calculateScenesExpenses', this.returnScenesExpenses);
        // this.on('creatScene', this.addScene);
        return super.init();
    }

    // async addScene(req) {
    //     const { movieID, description, duration, status } = req.data;
    //     const db = cds.db(req);

    //     // Ensure the movie exists
    //     const movie = await db.run(SELECT.one.from('sap.capire.moviestudioproject.Movies').where({ ID: movieID }));
    //     if (!movie) req.error(404, `Movie with ID ${movieID} not found`);

    //     // Insert new scene
    //     const [newScene] = await db.run(
    //         INSERT.into('sap.capire.moviestudioproject.Scenes').entries({
    //             ID: cds.utils.uuid(),
    //             movie_ID: movieID,
    //             description,
    //             duration,
    //             status
    //         })
    //     );

    //     return newScene;
    // }
    async returnScenesExpenses(req) {
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

module.exports = SceneService;