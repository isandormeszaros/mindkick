import mysql from 'mysql2';
import config from '../config/dbconfig.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const pool = mysql.createPool(config);

const executeQuery = (query, params) => {
    return new Promise((resolve, reject) => {
        pool.query(query, params, (err, results) => {
            if (err) return reject(err);
            return resolve(results);
        });
    });
};

export const registerUserService = async (username, email, password) => {
    // 1. Ellenőrzés, hogy létezik-e már
    const checkQuery = "SELECT * FROM users WHERE email = ? OR username = ?";
    const existingUser = await executeQuery(checkQuery, [email, username]);

    if (existingUser.length > 0) {
        throw new Error("USER_EXISTS");
    }

    // 2. Jelszó titkosítása
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 3. Mentés az adatbázisba
    const insertQuery = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    const result = await executeQuery(insertQuery, [username, email, hashedPassword]);
    
    // 4. Az új felhasználó azonosítójának lekérése
    const userId = result.insertId;

    // 5. TOKEN generálása (ugyanaz a logika, mint a login-nál)
    const token = jwt.sign(
        { id: userId, role: 'user' }, 
        process.env.JWT_SECRET || 'titkos_kulcs_fejleszteshez', 
        { expiresIn: '1d' }
    );

    // 6. Visszaadjuk a tokent és a felhasználó adatait
    return {
        token,
        user: {
            id: userId,
            username: username,
            email: email,
            role: 'user'
        }
    };
};

export const loginUserService = async (email, password) => {
    const query = "SELECT * FROM users WHERE email = ?";
    const users = await executeQuery(query, [email]);

    if (users.length === 0) {
        throw new Error("INVALID_CREDENTIALS");
    }

    const user = users[0];

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
        throw new Error("INVALID_CREDENTIALS");
    }

    const token = jwt.sign(
        { id: user.id, role: user.role },
        process.env.JWT_SECRET, 
        { expiresIn: '1d' }
    );

    return {
        token,
        user: {
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role
        }
    };
};