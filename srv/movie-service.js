const cds = require("@sap/cds");
const { c } = require("@sap/cds/lib/utils/tar");
const LOG = cds.log("movie-service");
class MoviesService extends cds.ApplicationService {
  init() {
    const { Movies } = this.entities;

    this.on("calculateTotalExpenses", this.returnTotalExpenses);

    this.on("setReleasedStatus", async (req) => {
      await UPDATE(req.subject).with({ movieStatus_code: "R", criticality: 3 });
      req.notify("Film Published!");
      return this.read(req.subject);
    });

    this.after("READ", Movies, this.setCriticality);

    this.on("sleep", async () => {
      try {
        let dbQuery = ' Call "sleep"( )';
        let result = await cds.run(dbQuery, {});
        cds.log().info(result);
        return true;
      } catch (error) {
        cds.log().error(error);
        return false;
      }
    });
    return super.init();
  }

  async setCriticality(movies) {
    for (let item of movies) {
      if (item.movieStatus?.code === "P") {
        item.criticality = 2;
      }
      if (item.movieStatus?.code === "R") {
        item.criticality = 3;
      }
      if (item.movieStatus?.code === "C") {
        item.criticality = 1;
      }
    }
  }

  async returnTotalExpenses(req) {
    const { movieID } = req.data;

    const { Expenses, Contracts, Scenes } = this.entities;

    const db = cds.db;
    const totalSceneExpenses = await db.run(
      SELECT("SUM(expense_amount) as total")
        .from(Expenses)
        .where({ "scene.movie_ID": movieID })
    );

    const totalSalaries = await db.run(
      SELECT("SUM(salary_amount) as total")
        .from(Contracts)
        .where({ movie_ID: movieID })
    );

    const sceneExpenses = totalSceneExpenses[0]?.total || 0;
    const salaries = totalSalaries[0]?.total || 0;
    const totalExpenses = sceneExpenses + salaries;

    return totalExpenses;
  }
}

module.exports = MoviesService;
