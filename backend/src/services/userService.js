import mysql from 'mysql2';
import config from '../config/dbconfig.js'; 

const pool = mysql.createPool(config);

const executeQuery = (query, params) => {
    return new Promise((resolve, reject) => {
        pool.query(query, params, (err, results) => {
            if (err) return reject(err);
            return resolve(results);
        });
    });
};

export const getUserProfileService = async (userId) => {
    const query = "SELECT id, username, email, display_name, role, created_at FROM users WHERE id = ?";
    const result = await executeQuery(query, [userId]);
    return result[0]; 
};

export const getAllBadgesService = async () => {
    const query = "SELECT * FROM badges";
    return await executeQuery(query);
};

export const getUserEarnedBadgesService = async (userId) => {
    const query = `
        SELECT b.id, b.name, b.description, b.icon, ub.earned_at 
        FROM badges b
        JOIN user_badges ub ON b.id = ub.badge_id
        WHERE ub.user_id = ?
    `;
    return await executeQuery(query, [userId]);
};