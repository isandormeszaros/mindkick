import config from "../config/dbconfig.js";
import mysql from "mysql2";

let pool = mysql.createPool(config);

// GET /allquiz
async function getQuizzes() {
  return new Promise((resolve, reject) => {
    const q = `
      SELECT q.id, q.title, q.description, q.difficulty, c.name as category_name 
      FROM quizzes q
      LEFT JOIN categories c ON q.category_id = c.id
      WHERE q.is_published = 1
    `;
    pool.query(q, (error, elements) => {
      if (error) {
        return reject(error);
      }
      return resolve(elements);
    });
  });
}

async function getQuizById(id) {
  return new Promise((resolve, reject) => {
    pool.query(
      "SELECT * FROM quizzes WHERE id = ?",
      [id],
      (error, quizElements) => {
        if (error) return reject(error);
        if (quizElements.length === 0) return resolve(null);

        const q = `
        SELECT 
          q.id as q_id, q.question_text, q.difficulty,
          o.id as o_id, o.option_text
        FROM quiz_questions qq
        JOIN questions q ON qq.question_id = q.id
        JOIN options o ON q.id = o.question_id
        WHERE qq.quiz_id = ?
        ORDER BY qq.order_index ASC, RAND()
      `;

        pool.query(q, [id], (error, rows) => {
          if (error) return reject(error);

          const map = {};
          rows.forEach((row) => {
            if (!map[row.q_id]) {
              map[row.q_id] = {
                id: row.q_id,
                text: row.question_text,
                difficulty: row.difficulty,
                options: [],
              };
            }
            map[row.q_id].options.push({
              id: row.o_id,
              text: row.option_text,
            });
          });

          resolve({
            info: quizElements[0],
            questions: Object.values(map),
          });
        });
      }
    );
  });
}

async function submitQuiz(quizId, userId, answers) {
  let score = 0;
  let total = answers.length;
  let details = {};

  const checkPromises = answers.map((ans) => {
    return new Promise((resolve, reject) => {
      pool.query(
        "SELECT id, is_correct FROM options WHERE question_id = ?",
        [ans.questionId],
        (error, results) => {
          if (error) return reject(error);

          const correctOption = results.find((opt) => opt.is_correct === 1);

          if (correctOption) {
            details[ans.questionId] = correctOption.id;
          }

          const isCorrect = correctOption && (ans.selectedOptionId === correctOption.id);
          if (isCorrect) score++;

          if (userId) {
            pool.query(
              "INSERT INTO question_logs (user_id, quiz_id, question_id, selected_option_id, is_correct) VALUES (?, ?, ?, ?, ?)",
              [
                userId,
                quizId,
                ans.questionId,
                ans.selectedOptionId,
                isCorrect ? 1 : 0,
              ],
              (logErr) => {
                if (logErr) console.log("Log error:", logErr);
                resolve();
              }
            );
          } else {
            resolve();
          }
        }
      );
    });
  });

  await Promise.all(checkPromises);

  if (userId) {
    await new Promise((resolve, reject) => {
      pool.query(
        "INSERT INTO results (user_id, quiz_id, score, total_questions) VALUES (?, ?, ?, ?)",
        [userId, quizId, score, total],
        (error) => {
          if (error) return reject(error);
          resolve();
        }
      );
    });
  }

  const recommendedQuiz = await new Promise((resolve) => {
    const q = `
      SELECT id, title, difficulty 
      FROM quizzes 
      WHERE id != ? AND is_published = 1 
      ORDER BY RAND() 
      LIMIT 1
    `;
    
    pool.query(q, [quizId], (err, rows) => {
      if (err) {
        console.log("Recommendation error:", err);
        // Ha itt hiba van, NULL értékkel tér vissza, hogy ne crasheljen ki a játék.
        return resolve(null);
      }
      resolve(rows.length > 0 ? rows[0] : null);
    });
  });

  return {
    success: true,
    score: score,
    total: total,
    percentage: Math.round((score / total) * 100),
    recommendedQuiz: recommendedQuiz,
    evaluation: details,
  };
}

export default {
  getQuizzes,
  getQuizById,
  submitQuiz,
};
