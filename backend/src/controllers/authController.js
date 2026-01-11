import { registerUserService, loginUserService } from '../services/authService.js';

export const register = async (req, res) => {
    try {
        const { username, email, password } = req.body;

        if (!username || !email || !password) {
            return res.status(400).json({ error: "Minden mező kitöltése kötelező!" });
        }

        // 1. Regisztráljuk a felhasználót és visszakapjuk az adatait + tokent
        // (Ehhez az authService.js-ben a registerUserService-nek is vissza kell térnie ezekkel)
        const data = await registerUserService(username, email, password);
        
        // 2. Azonnal visszaküldjük a tokent, így a frontend be tudja léptetni
        res.status(201).json({ 
            message: "Sikeres regisztráció!",
            token: data.token,
            user: data.user
        });

    } catch (error) {
        if (error.message === "USER_EXISTS") {
            return res.status(409).json({ error: "Ez a felhasználónév vagy email már foglalt!" });
        }
        console.error("Regisztrációs hiba:", error);
        res.status(500).json({ error: "Szerver hiba történt." });
    }
};

export const login = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ error: "Email és jelszó megadása kötelező!" });
        }

        const data = await loginUserService(email, password);

        res.status(200).json({
            message: "Sikeres bejelentkezés!",
            token: data.token,
            user: data.user
        });

    } catch (error) {
        if (error.message === "INVALID_CREDENTIALS") {
            return res.status(401).json({ error: "Hibás email vagy jelszó!" });
        }
        console.error("Login hiba:", error);
        res.status(500).json({ error: "Szerver hiba történt." });
    }
};