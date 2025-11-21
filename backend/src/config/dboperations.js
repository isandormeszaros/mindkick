import config from "../config/dbconfig.js";
import mysql from "mysql2";

let pool = mysql.createPool(config);

// GET /allquiz
async function getQuiz() {
  return new Promise((resolve, reject) => {
    pool.query("SELECT * FROM quiz.categories;", (error, elements) => {
      if (error) {
        return reject(error);
      }
      return resolve(elements);
    });
  });
}

export default getQuiz;
